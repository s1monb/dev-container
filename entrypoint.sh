#!/bin/bash

set -eu

# Give full access to the volume mount (folder with .config)
if [ -d "$HOME/dev" ]; then
  echo "Changing permissions of mounted volume folder to be world-writable"
  chmod -R 777 "$HOME/dev"
fi

# Switch to simon user and run the main command
exec gosu "$USERNAME" "$@"
export XDG_CONFIG_HOME="/home/simon/.dotfiles"

cd dev/ && tmux new-session