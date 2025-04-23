#!/bin/bash

set -eu

export XDG_CONFIG_HOME="/home/simon/.dotfiles"

cd dev/ && tmux new-session