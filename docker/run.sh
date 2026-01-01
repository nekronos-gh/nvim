#!/bin/bash

IMAGE_NAME="nvim-dev:latest"
DOCKERFILE_PATH="./docker/Dockerfile"

# Build image if it doesn't exist
if [[ "$(docker images -q $IMAGE_NAME 2> /dev/null)" == "" ]]; then
    echo "Building Neovim Docker image..."
    docker build -t $IMAGE_NAME -f $DOCKERFILE_PATH .
    echo "Image built successfully!"
fi

# Run nvim in container with current directory mounted
docker run --rm -it \
    -v "$(pwd):/workspace" \
    -w /workspace \
    $IMAGE_NAME "$@"
