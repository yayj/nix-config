if [ -S "${HOME}/.gnupg/S.gpg-agent.ssh" ]; then
  export GPG_TTY="$(tty)"
  export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"
elif [ -S "${SSH_AUTH_SOCK}" ]; then
  mkdir -p "${HOME}/.ssh"
  chmod go-rwx "${HOME}/.ssh"
  ln -sf "${SSH_AUTH_SOCK}" "${HOME}/.ssh/agent.sock"
  export SSH_AUTH_SOCK="${HOME}/.ssh/agent.sock"
else
  rm -f "${HOME}/.ssh/agent.sock"
fi
