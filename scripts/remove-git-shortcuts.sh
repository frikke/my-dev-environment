#!/bin/bash

SOURCE_PATH=$(dirname "$0")
source "$SOURCE_PATH/utils.sh"

printf "Removing git shortcuts from $PROFILE_FILE...\n"

if [ ! -e "$PROFILE_FILE" ]
then
  printf "Profile file not found! All done here!\n\n"
  exit 0
fi

sed_inplace '/## Git Shortcuts ###/d' "$PROFILE_FILE"
sed_inplace "/alias gs='git status'/d" "$PROFILE_FILE"
sed_inplace "/alias ga='git add'/d" "$PROFILE_FILE"
sed_inplace "/alias gd='git diff'/d" "$PROFILE_FILE"
sed_inplace "/alias gc='git commit'/d" "$PROFILE_FILE"
sed_inplace "/alias gp='git pull'/d" "$PROFILE_FILE"
sed_inplace "/alias gch='git checkout'/d" "$PROFILE_FILE"

printf "Git Shortcuts are gone\n\n"
