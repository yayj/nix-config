#!/usr/bin/env -S just --justfile

just := just_executable() + " -f " + justfile()

stow := "stow --override='.*' --no-folding -t ${HOME} -d " + justfile_directory()

help:
  @{{just}} --list

[macos]
_darwin:
  #!/bin/sh
  set -eu

  {{stow}} darwin

  chmod 700 "${HOME}/.gnupg"

  rime="${HOME}/Library/Rime"

  dpy_ver="69bf85d4dfe8bac139c36abbd68d530b8b6622ea"
  for name in {"double_pinyin","double_pinyin_flypy"}; do
    file="${name}.schema.yaml"
    curl -LSso "${rime}/${file}" \
         "https://raw.githubusercontent.com/rime/rime-double-pinyin/${dpy_ver}/${file}"
  done

  dic_ver="2025.04.06"
  for name in {"8105","base","ext","others","tencent"}; do
    file="${name}.dict.yaml"
    curl -LSso "${rime}/dicts/${file}" \
         "https://raw.githubusercontent.com/iDvel/rime-ice/${dic_ver}/cn_dicts/${file}"
  done

_common:
  @{{stow}} common

_server:
  @{{stow}} server

@setup pkg *pkgs:
  {{just}} "_{{pkg}}"
  {{ if pkgs != "" { just + " setup " + pkgs } else { "" } }}

remove +pkgs:
  @{{stow}} -D {{pkgs}}
