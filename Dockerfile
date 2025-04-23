FROM ubuntu:25.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y git curl tmux gcc unzip make ripgrep

ARG USER_ID=1000
ARG GROUP_ID=1000

# Create a group and a user with specific UID and GID
RUN groupadd -g ${GROUP_ID} simon \
    && useradd -u ${USER_ID} -g ${GROUP_ID} -ms /bin/bash simon
USER simon

WORKDIR /home/simon

# Install neovim
RUN curl -Lo nvim-linux64.tar.gz https://github.com/neovim/neovim-releases/releases/download/v0.10.1/nvim-linux64.tar.gz \
    && tar xzf nvim-linux64.tar.gz \
    && mv /home/simon/nvim-linux64 /home/simon/.nvim-linux64 \
    && mkdir -p /home/simon/.local/bin \
    && mkdir -p /home/simon/.config/nvim \
    && mkdir -p /home/simon/.ssh \
    && mkdir -p /home/simon/dev \
    && ln -s /home/simon/.nvim-linux64/bin/nvim /home/simon/.local/bin/nvim \
    && rm nvim-linux64.tar.gz

ENV PATH="/home/simon/.local/bin:$PATH"

RUN mkdir -p ~/.dotfiles
COPY --chown=simon:simon ./dotfiles /home/simon/.dotfiles
COPY --chown=simon:simon .nvim-data/share /home/simon/.local/share
COPY --chown=simon:simon .nvim-data/state /home/simon/.local/state

RUN echo 'export XDG_CONFIG_HOME="/home/simon/.dotfiles"' >> ~/.bashrc
RUN echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> ~/.bashrc

# Setup neovim

COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]