if [[ -n "${ORIGIN_AUTH_SOCK}" && \
        "$(readlink -f "${SSH_AUTH_SOCK}")" = "${ORIGIN_AUTH_SOCK}" ]]; then
  local found=""

  while IFS= read -r sock; do
    if [[ "${sock}" != "${ORIGIN_AUTH_SOCK}" ]]; then
      found="${sock}"
      break
    fi
  done <<(fd -t s -d 1 -o "${USER}" '^agent\.\d+$' /tmp/ssh-??????????)

  if [[ -n "${found}" ]]; then
    ln -sf "${found}" "${FIXED_AUTH_SOCK}"
  else
    rm -f "${FIXED_AUTH_SOCK}"
  fi
fi
