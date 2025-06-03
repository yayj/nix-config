setopt prompt_subst
autoload -Uz vcs_info
precmd() { vcs_info }

+vi-git-dirty() {
  if [[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" == 'true' ]]; then
    output="$(git status --porcelain 2>/dev/null)"
    if echo "${output}" | grep -sqE '^\?\?'; then
      hook_com[misc]+=' %F{red}?%f'
    elif echo "${output}" | grep -sqE '^.[^ ]'; then
      hook_com[misc]+=' %F{red}δ%f'
    elif echo "${output}" | grep -sqE '^[^ ] '; then
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

PROMPT='%(?.%F{blue}λ.%F{red}ε)%f '
PROMPT+='%F{cyan}%c%f '
PROMPT+='${vcs_info_msg_0_}'
PROMPT+='%F{yellow}»%f '

unset RPROMPT
