#!/bin/bash

SOURCE_PATH=$(dirname "$0")
source "$SOURCE_PATH/utils.sh"

if [[ "$OS_TYPE" == "macos" ]]; then
    if [[ $(command -v brew) != "" ]] && [[ "$1" != "-f" ]]; then
        printf "Oops! You already have Homebrew installed!\nUse -f as last parameter to force an update!\n\n"
    else
        if [[ $(command -v brew) != "" ]]; then
            printf "Removing old Homebrew install..\n"
            "$SOURCE_PATH/remove-brew.sh"
        fi

        printf "Installing Homebrew...\n"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        add_to_profile "## Add Brew bin in the path ###"
        add_to_profile "export PATH='\$PATH:/opt/homebrew/bin'"
        add_to_profile 'eval "$(/opt/homebrew/bin/brew shellenv)"'
        
        printf "Homebrew Installed!\n"
    fi
elif [[ "$OS_TYPE" == "linux-ubuntu" ]]; then
    printf "Updating apt packages list...\n"
    sudo apt-get update
    printf "Installing base dependencies...\n"
    sudo apt-get install -y curl wget git build-essential
    printf "Base system ready!\n"
else
    printf "OS not supported for base setup: $OS_TYPE\n"
fi
