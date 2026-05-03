#!/bin/sh
printf '\033c\033]0;%s\a' 2d-game-project
base_path="$(dirname "$(realpath "$0")")"
"$base_path/ant-raph.x86_64" "$@"
