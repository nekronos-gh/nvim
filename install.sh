#!/bin/bash
set -e

NVIM_REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_DOCKER_SCRIPT="$NVIM_REPO_DIR/docker/run.sh"

# Check if shell argument is provided
if [ $# -eq 0 ]; then
    echo "Error: Shell type is required"
    echo "Usage: $0 <bash|zsh>"
    exit 1
fi

SHELL_TYPE="$1"

# Determine shell config file
case "$SHELL_TYPE" in
    bash)
        SHELL_CONFIG="$HOME/.bashrc"
        ;;
    zsh)
        SHELL_CONFIG="$HOME/.zshrc"
        ;;
    *)
        echo "Error: Unsupported shell type '$SHELL_TYPE'"
        echo "Supported shells: bash, zsh"
        exit 1
        ;;
esac

echo "Installing Nvim Config for $SHELL_TYPE..."

# Check if already installed
if grep -q "# NEKRONOS NVIM" "$SHELL_CONFIG" 2>/dev/null; then
    echo "Nvim already installed in $SHELL_CONFIG."
else
    cat >> "$SHELL_CONFIG" <<EOF

# NEKRONOS SSH AGENT
# Start SSH agent if not running (needed for Docker nvim)
if [ -z "\$SSH_AUTH_SOCK" ]; then
    eval "\$(ssh-agent -s)" > /dev/null
    # Add all private keys from ~/.ssh (excluding .pub files and known files)
    for key in ~/.ssh/*; do
        if [[ -f "\$key" && ! "\$key" =~ \.(pub|known_hosts|config|authorized_keys)$ ]]; then
            ssh-add "\$key" 2>/dev/null || true
        fi
    done
fi

# NEKRONOS NVIM
nvim() {
    local use_docker=false
    local nvim_args=()
    
    for arg in "\$@"; do
        if [[ "\$arg" == "--docker" ]]; then
            use_docker=true
        else
            nvim_args+=("\$arg")
        fi
    done
    
    if [ "\$use_docker" = true ]; then
        bash "$NVIM_DOCKER_SCRIPT" "\${nvim_args[@]}"
    else
        command nvim "\$@"
    fi
}

# vim aliases
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
EOF
fi
