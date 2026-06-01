#!/bin/bash

SOURCE_PATH=$(dirname "$0")
source "$SOURCE_PATH/utils.sh"

if [[ $(command -v docker) != "" ]] && [[ "$1" != "-f" ]]; then
  printf "Oops! You already have Docker installed!\nUse -f as last parameter to force an update!\n\n"
else
  if [[ $(command -v docker) != "" ]]; then
    printf "Removing docker that is installed...\n\n"
    "$SOURCE_PATH/remove-docker.sh"
  fi

  if [[ "$OS_TYPE" == "macos" ]]; then
    printf "Installing Docker Desktop for Mac...\n"
    # For M1/M2 Macs
    if [[ $(uname -m) == "arm64" ]]; then
        softwareupdate --install-rosetta --agree-to-license
        add_to_profile "## M1 Platform adjust for Docker ###"
        add_to_profile "export DOCKER_DEFAULT_PLATFORM=linux/amd64"
    fi
    brew install --cask docker
    printf "Docker installed!\n\n"
    printf "Opening Docker App...\n"
    open /Applications/Docker.app
  elif [[ "$OS_TYPE" == "linux-ubuntu" ]]; then
    printf "Installing Docker Engine for Ubuntu...\n"
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    
    sudo groupadd docker 2>/dev/null
    sudo usermod -aG docker "$USER"
    printf "Docker installed! You might need to logout and login again for group changes to take effect.\n"
  fi
fi
