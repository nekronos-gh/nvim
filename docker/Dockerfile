FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    unzip \
    tar \
    gzip \
    build-essential \
    ripgrep \
    fd-find \
    nodejs \
    npm \
    python3 \
    python3-pip \
    zsh \
    locales \
    && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8

# Install Neovim 
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz \
    && tar -xzf nvim-linux-x86_64.tar.gz \
    && mv nvim-linux-x86_64 /opt/nvim \
    && ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim \
    && rm nvim-linux-x86_64.tar.gz
RUN git clone https://github.com/nekronos-gh/nvim ~/.config/nvim
RUN nvim --headless "+Lazy! sync" +qa


# Install Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
RUN sed -i 's/plugins=(git)/plugins=(git docker python zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

ENV SHELL=/bin/zsh

WORKDIR /workspace

# Setup git
COPY ./.gitconfig /root/.gitconfig
COPY ./.gitignore /root/.gitignore
RUN git config --global --add safe.directory /workspace \
    && git config --global core.excludesfile /root/.gitignore

ENTRYPOINT ["nvim"]
