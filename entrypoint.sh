#!/bin/bash

set -eu

chown -R simon:1000 /home/simon/dev

# Switch to simon user and run the main command
exec gosu simon "$@"

export XDG_CONFIG_HOME="/home/simon/.dotfiles"

cd dev/ && tmux new-session