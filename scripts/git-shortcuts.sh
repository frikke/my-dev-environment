#!/bin/bash

SOURCE_PATH=$(dirname "$0")
source "$SOURCE_PATH/utils.sh"

if [[ $(grep -l "alias gs='git status'" "$PROFILE_FILE" 2>/dev/null) != "" ]] && [[ "$1" != "-f" ]]; then
  printf "Looks like you already have some git shortcuts in your profile..\nUse -f to remove them and re-add them.\n\n"
else
  if [[ $(grep -l "alias gs='git status'" "$PROFILE_FILE" 2>/dev/null) != "" ]]; then
    printf "Removing actual git shortcuts...\n"
    "$SOURCE_PATH/remove-git-shortcuts.sh"
  fi

  printf "Creating shortcuts in $PROFILE_FILE...\n"
  
  add_to_profile "## Git Shortcuts ###"
  add_to_profile "alias gs='git status'"
  add_to_profile "alias ga='git add'"
  add_to_profile "alias gd='git diff'"
  add_to_profile "alias gc='git commit'"
  add_to_profile "alias gp='git pull'"
  add_to_profile "alias gch='git checkout'"
  
  printf "Shortcuts created!\n\n"
fi
