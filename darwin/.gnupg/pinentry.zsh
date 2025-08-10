#!/usr/bin/env zsh

if (( $+commands[pinentry-mac] )); then
  exec pinentry-mac "$@"
elif (( $+commands[pinentry-tty] )); then
  exec pinentry-tty "$@"
else
  exec pinentry "$@"
fi
