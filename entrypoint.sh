#!/bin/bash

set -eu
echo "Starting entrypoint.sh"
echo "Running migrations..."

export XDG_CONFIG_HOME="/home/simon/.dotfiles"

cd dev/ && tmux new-session