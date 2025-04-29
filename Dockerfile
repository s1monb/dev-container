FROM ubuntu:24.04



RUN apt-get update && \
    apt-get install build-essential curl file git ruby-full tmux gcc wget unzip make ripgrep fish locales --no-install-recommends -y && \
    rm -rf /var/lib/apt/lists/*

RUN localedef -i en_US -f UTF-8 en_US.UTF-8
RUN useradd -g 1000 -ms /bin/bash simon && \
    useradd -m -s /bin/bash linuxbrew && \
    echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers && \
    echo 'simon ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Install neovim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz && \
    rm -rf /opt/nvim && \
    tar -C /opt -xzf nvim-linux-x86_64.tar.gz && \
    mv /opt/nvim-linux-x86_64 /opt/nvim

USER linuxbrew
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

USER root
RUN chown -R simon /home/linuxbrew

USER simon
WORKDIR /home/simon

RUN mkdir -p ~/.dotfiles
COPY --chown=simon:simon ./dotfiles /home/simon/.dotfiles

COPY ./scripts /scripts

ENV PATH="/opt/nvim/bin:${PATH}"
ENV XDG_CONFIG_HOME="/home/simon/.dotfiles"

CMD ["fish"]

