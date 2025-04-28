FROM ubuntu:24.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y git curl tmux gcc wget unzip make ripgrep fish nodejs npm

# Install neovim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz && \
    rm -rf /opt/nvim && \
    tar -C /opt -xzf nvim-linux-x86_64.tar.gz && \
    mv /opt/nvim-linux-x86_64 /opt/nvim

# Create a group and a user with specific UID and GID
RUN useradd -g 1000 -ms /bin/bash simon
USER simon

WORKDIR /home/simon

RUN mkdir -p ~/.dotfiles
COPY --chown=simon:simon ./dotfiles /home/simon/.dotfiles

COPY ./scripts /scripts

ENV PATH="/opt/nvim/bin:${PATH}"
ENV XDG_CONFIG_HOME="/home/simon/.dotfiles"

CMD ["fish"]

