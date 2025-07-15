FROM ubuntu:25.04
ARG USER_ID
ARG GROUP_ID

# Delete default user with uid 1000 and gid 1000
RUN userdel -r ubuntu

# Install dependencies
RUN apt-get update && \
    apt-get install build-essential curl file git ruby-full tmux gcc wget ssh unzip make ripgrep fish fd-find fzf openssh-server --no-install-recommends -y

RUN apt-get install libwebkit2gtk-4.1-dev \
  libxdo-dev \
  libssl-dev \
  libayatana-appindicator3-dev \
  librsvg2-dev --no-install-recommends -y

# Create linuxbrew user and add to sudoers
RUN groupadd -g 2000 linuxbrew && useradd -u 2000 -g linuxbrew -m -s /bin/bash linuxbrew && \
    echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers
RUN groupadd -g $GROUP_ID dev && useradd -u $USER_ID -g dev -m -s /bin/bash dev && \
    echo 'dev ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

USER linuxbrew
COPY ./env/.config/Brewfile /home/linuxbrew/Brewfile

# Install Homebrew and all packages specified in Brewfile (dotfiles/Brewfile)
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
RUN /home/linuxbrew/.linuxbrew/bin/brew bundle --file=/home/linuxbrew/Brewfile
RUN /home/linuxbrew/.linuxbrew/bin/brew cleanup

USER root

# Give ubuntu user access to all linuxbrew stuff
RUN chown -R dev:dev /home/linuxbrew

WORKDIR /home/dev
COPY --chown=dev:dev ./env/.config .config

COPY ./scripts /scripts

# root user will install/download online dependencies (see scripts/initialize-tooling.sh)
# and we want them to be available to the ubuntu user
ENV XDG_CONFIG_HOME=/home/dev/.config
ENV XDG_DATA_HOME=/home/dev/.local/share
ENV XDG_CACHE_HOME=/home/dev/.cache
ENV XDG_STATE_HOME=/home/dev/.local/state

USER dev

RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain stable -y && \
    /home/dev/.cargo/bin/rustup update beta && \
    /home/dev/.cargo/bin/rustup update nightly

USER root
