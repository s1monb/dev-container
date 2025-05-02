FROM ubuntu:25.04

# Install dependencies
RUN apt-get update && \
    apt-get install build-essential curl file git ruby-full tmux gcc wget unzip make ripgrep fish fd-find fzf --no-install-recommends -y

# Create linuxbrew user and add to sudoers
RUN groupadd -g 2000 linuxbrew && useradd -u 2000 -g linuxbrew -m -s /bin/bash linuxbrew && \
    echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

USER linuxbrew
COPY ./dotfiles/Brewfile /home/linuxbrew/Brewfile

# Install Homebrew and all packages specified in Brewfile (dotfiles/Brewfile)
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
RUN /home/linuxbrew/.linuxbrew/bin/brew bundle --file=/home/linuxbrew/Brewfile
RUN /home/linuxbrew/.linuxbrew/bin/brew cleanup

USER root

# Give ubuntu user access to all linuxbrew stuff
RUN chown -R ubuntu:ubuntu /home/linuxbrew

WORKDIR /home/ubuntu
COPY --chown=ubuntu:ubuntu ./dotfiles .config

COPY ./scripts /scripts

# root user will install/download online dependencies (see scripts/initialize-tooling.sh)
# and we want them to be available to the ubuntu user
ENV XDG_CONFIG_HOME=/home/ubuntu/.config
ENV XDG_DATA_HOME=/home/ubuntu/.local/share
ENV XDG_CACHE_HOME=/home/ubuntu/.cache
ENV XDG_STATE_HOME=/home/ubuntu/.local/state
