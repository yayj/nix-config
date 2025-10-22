setup_ohmyzsh() {
  if [ -d "${ZSH}" ] && [ -f "${ZSH}/oh-my-zsh.sh" ]; then
    return
  fi
  mkdir -p "${ZSH}" && \
    git init --quiet "${ZSH}" && \
    cd "${ZSH}" && \
    git config core.eol lf && \
    git config core.autocrlf false && \
    git config fsck.zeroPaddedFilemode ignore && \
    git config fetch.fsck.zeroPaddedFilemode ignore && \
    git config receive.fsck.zeroPaddedFilemode ignore && \
    git config oh-my-zsh.remote origin && \
    git config oh-my-zsh.branch master && \
    git remote add origin https://github.com/ohmyzsh/ohmyzsh.git && \
    git fetch --depth=1 origin && \
    git checkout -b master origin/master || {
      [ ! -d "${ZSH}" ] || {
        cd -
        rm -rf "${ZSH}" 2>/dev/null
      }
      echo "git clone of oh-my-zsh repo failed" >&2
      exit 1
    }
  cd -
}

setup_theme() {
  [ -f "${ZSH}/themes/matt.zsh-theme" ] || {
    cat > "${ZSH}/themes/matt.zsh-theme" <<EOF
setopt PROMPT_SUBST
autoload -Uz vcs_info
precmd() { vcs_info }

+vi-git-dirty() {
  if [[ "\$(git rev-parse --is-inside-work-tree 2>/dev/null)" == 'true' ]]; then
    output="\$(git status --porcelain 2>/dev/null)"
    if echo "\${output}" | grep -sqE '^\?\?'; then
      hook_com[misc]+=' %F{red}?%f'
    elif echo "\${output}" | grep -sqE '^.[^ ]'; then
      hook_com[misc]+=' %F{red}δ%f'
    elif echo "\${output}" | grep -sqE '^[^ ] '; then
      hook_com[misc]+=' %F{yellow}Δ%f'
    fi
  fi
}

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*+set-message:*' hooks git-dirty
zstyle ':vcs_info:git:*' formats '%F{blue}(%f%F{red}%b%f%m%F{blue})%f '
zstyle ':vcs_info:git:*' actionformats '%F{blue}(%f%F{red}%b|%a%f%F{blue})%f '
zstyle ':vcs_info:git-svn:*' formats '%F{blue}(%f%F{red}%b%f%m%F{blue})%f '
zstyle ':vcs_info:git-svn:*' actionformats '%F{blue}(%f%F{red}%b|%a%f%F{blue})%f '

if [[ -n "\${name}" ]]; then
  PROMPT='%(?.%F{blue}.%F{red})\${name}%f '
else
  PROMPT='%(?.%F{blue}λ.%F{red}ε)%f '
fi
PROMPT+='%F{cyan}%c%f '
PROMPT+='\${vcs_info_msg_0_}'
PROMPT+='%F{yellow}»%f '

unset RPROMPT

EOF
  }
}

typeset -U path cdpath fpath manpath

for profile in ${(z)NIX_PROFILES}; do
  fpath+=($profile/share/zsh/site-functions $profile/share/zsh/$ZSH_VERSION/functions $profile/share/zsh/vendor-completions)
done

# Use emacs keymap as the default.
bindkey -e

setup_ohmyzsh
setup_theme

ZSH_THEME="matt"

plugins=(brew fzf git kitty rsync)
source "${ZSH}/oh-my-zsh.sh"

HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="${HOME}/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
unsetopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
unsetopt HIST_SAVE_NO_DUPS
unsetopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY


alias -- b='brew'
alias -- e='emacsclient -a "" -c -n'
alias -- ee='emacsclient -e'
alias -- em='emacsclient -a "" -t'
alias -- gl='git gl'
alias -- gla='git gla'
alias -- glav='git glav'
alias -- glv='git glv'
alias -- gs='git st'
alias -- j='jobs -l'
