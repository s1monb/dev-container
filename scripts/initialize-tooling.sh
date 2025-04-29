#!/bin/fish

cd /home/simon

export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"

brew bundle --file=/home/simon/.dotfiles/Brewfile

nvim --headless -c 'Lazy! sync' -c 'MasonInstall typescript-language-server' -c 'qa!'