if [[ -d ~/.nix-profile/bin && ! ":$PATH:" =~ ":$HOME/.nix-profile/bin:" ]]; then
  export PATH="$HOME/.nix-profile/bin:$PATH"
fi

export EDITOR="emacsclient -a '' -t"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export PAGER="bat"

ZSH="${HOME}/.omz"
ZSH_CACHE_DIR="${HOME}/.cache/oh-my-zsh"
