#!/bin/bash

SOURCE_PATH=$(dirname "$0")
source "$SOURCE_PATH/utils.sh"

if command -v brew &>/dev/null; then
  printf "Removing Homebrew.. Will Require Password..\n"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
else
  printf "Looks like Homebrew is not installed.. Everything good here!\n\n"
fi

sed_inplace '/## Add Brew bin in the path ###/d' "$PROFILE_FILE"
sed_inplace '/homebrew/d' "$PROFILE_FILE"

printf "Homebrew has gone..\n\n"
