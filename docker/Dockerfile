FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install essential packages
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    build-essential \
    ripgrep \
    fd-find \
    nodejs \
    npm \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install Neovim (latest stable)
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz \
    && tar -xzf nvim-linux-x86_64.tar.gz \
    && mv nvim-linux-x86_64 /opt/nvim \
    && ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim \
    && rm nvim-linux-x86_64.tar.gz

# Clone your config
RUN git clone https://github.com/nekronos-gh/nvim ~/.config/nvim

# Pre-install plugins (run headless to trigger lazy.nvim)
RUN nvim --headless "+Lazy! sync" +qa

WORKDIR /workspace

ENTRYPOINT ["nvim"]
