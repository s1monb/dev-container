#!/bin/bash

set -eu

# Default to simon user
USERNAME="simon"
USER_HOME="/home/${USERNAME}"

# If the volume is mounted and UID is different, fix it
if [ -n "$HOST_UID" ] && [ -n "$HOST_GID" ]; then
  echo "Updating UID/GID to match host: UID=$HOST_UID, GID=$HOST_GID"

  groupmod -g "$HOST_GID" "$USERNAME"
  usermod -u "$HOST_UID" -g "$HOST_GID" "$USERNAME"
  chown -R "$USERNAME:$USERNAME" "$USER_HOME"
fi

# Switch to simon and run
exec gosu "$USERNAME" "$@"
export XDG_CONFIG_HOME="/home/simon/.dotfiles"

cd dev/ && tmux new-session