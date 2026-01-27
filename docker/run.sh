#!/bin/bash

set -e  # Exit on error

# Configuration
readonly DEFAULT_IMAGE="nvim-dev:latest"
readonly REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DEFAULT_DOCKERFILE="$REPO_DIR/Dockerfile"

# Sync host configs to docker context for build
cp "$HOME/.gitconfig" "$REPO_DIR/.gitconfig"
cp "$HOME/.gitignore" "$REPO_DIR/.gitignore"
cp "$HOME/.config/opencode/package.json" "$REPO_DIR/package.json"

# Function to build image if it doesn't exist
build_image_if_needed() {
    local image_name="$1"
    local dockerfile_path="$2"
    local build_context="$3"
    
    if [[ "$(docker images -q "$image_name" 2> /dev/null)" == "" ]]; then
        docker build -t "$image_name" -f "$dockerfile_path" "$build_context"
    fi
}

# Ensure default base image exists
build_image_if_needed "$DEFAULT_IMAGE" "$DEFAULT_DOCKERFILE" "$REPO_DIR/.."

# Determine which image to use
if [[ -f ".devcontainer/Dockerfile" ]]; then
    # Use project-specific image
    PROJECT_NAME=$(basename "$(pwd)" | tr '[:upper:]' '[:lower:]')
    IMAGE_NAME="nvim-${PROJECT_NAME}:latest"
    DOCKERFILE_PATH=".devcontainer/Dockerfile"
    BUILD_CONTEXT="."
    
    build_image_if_needed "$IMAGE_NAME" "$DOCKERFILE_PATH" "$BUILD_CONTEXT"
else
    # Use default image
    IMAGE_NAME="$DEFAULT_IMAGE"
fi

# Run Neovim in container
docker run --rm -it \
    -v "$(pwd):/workspace" \
    -v "$HOME/.config/opencode:/root/.config/opencode" \
    -v "$HOME/.local/share/opencode:/root/.local/share/opencode" \
    -v "$SSH_AUTH_SOCK:/ssh-agent" \
    -e SSH_AUTH_SOCK=/ssh-agent \
    -w /workspace \
    "$IMAGE_NAME" "$@"
