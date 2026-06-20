if [[ -n "${ORIGIN_AUTH_SOCK}" && \
        "$(readlink -f "${SSH_AUTH_SOCK}")" = "${ORIGIN_AUTH_SOCK}" ]]; then
  local found=""
  local socks=(
    ${(f)"$(fd -t s -d 1 -o ${USER} '^agent\.\d+$' /tmp/ssh-?????????? 2>/dev/null)"}
    ${(f)"$(fd -t s -d 1 '^s\.' ${HOME}/.ssh/agent 2>/dev/null)"}
  )

  for sock in "${socks[@]}"; do
    if [[ "${sock}" != "${ORIGIN_AUTH_SOCK}" ]] && \
         SSH_AUTH_SOCK="${sock}" ssh-add -l >/dev/null 2>&1; then
      found="${sock}"
      break
    fi
  done

  if [[ -n "${found}" ]]; then
    ln -sf "${found}" "${FIXED_AUTH_SOCK}"
  else
    rm -f "${FIXED_AUTH_SOCK}"
  fi
fi
