#!/bin/fish

# Install all nvim dependencies to ubuntu's home directory as root
nvim --headless -c 'Lazy! sync' -cq

#  Language-spesific tooling

# Golang-tooling 
nvim --headless -c 'MasonInstall gopls delve golangci-lint goimports golines gofumpt gotests' -cq
# Lua-tooling
nvim --headless -c 'MasonInstall lua-language-server luacheck stylua luaformatter' -cq
# Markdown
nvim --headless -c 'MasonInstall marksman markdownlint-cli2' -cq
# JavaScript/TypeScript React
nvim --headless -c 'MasonInstall deno eslint_d typescript-language-server ts-standard ast-grep' -cq

nvim --headless -c 'TSInstallSync all' -cq

# Change ownership of the home directory to ubuntu (for the nvim dependencies)
chown -R ubuntu:ubuntu /home/ubuntu
chmod -R 770 /home/ubuntu

rm -rf /home/ubuntu/.cache /home/linuxbrew/.cache
