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

echo "Done with nvim setup"

# Change ownership of the home directory to ubuntu (for the nvim dependencies)
chown -R dev:dev /home/dev
chmod -R 770 /home/dev

npm install -g @anthropic-ai/claude-code

rm -rf /home/dev/.cache /home/linuxbrew/.cache
