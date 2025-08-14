mkdir -pm 700 "${HOME}/.ssh"
FIXED_AUTH_SOCK="${HOME}/.ssh/agent.sock"

if ssh-add -l >/dev/null 2>&1; then
  ORIGIN_AUTH_SOCK="${SSH_AUTH_SOCK}"
  ln -sf "${ORIGIN_AUTH_SOCK}" "${FIXED_AUTH_SOCK}"
  export SSH_AUTH_SOCK="${FIXED_AUTH_SOCK}"
elif (( $+commands[gpg-connect-agent] )); then
  gpg-connect-agent -q /bye
  export GPG_TTY="$(tty)"
  export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"
fi

fastfetch
