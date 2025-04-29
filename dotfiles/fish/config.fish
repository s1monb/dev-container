#  Entry point that includes all other configs
#  
#  Author: [Dmitry](http://dmi3.net) [Source](https://github.com/dmi3/fish)

set -q XDG_CONFIG_HOME || set XDG_CONFIG_HOME "$HOME/.dotfiles"

export GOPATH="/go"
export PATH="$GOPATH/bin:/usr/local/go/bin:$PATH"

export PATH="$PATH:/opt/nvim/bin:/home/linuxbrew/.linuxbrew/bin"