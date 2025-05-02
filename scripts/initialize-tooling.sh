#!/bin/fish

# Install all nvim dependencies to ubuntu's home directory as root
nvim --headless -c 'Lazy! sync' -c 'MasonInstall typescript-language-server' -c 'qa!'

# Change ownership of the home directory to ubuntu (for the nvim dependencies)
chown -R ubuntu:ubuntu /home/ubuntu
chmod -R 770 /home/ubuntu

rm -rf /home/ubuntu/.cache /home/linuxbrew/.cache
