#!/bin/bash
# Copyright (C) 2026 ZeroDream
# https://github.com/zero-dream

# --------------------------------------------------

# SetEnv
# The variable is accessible to the current process and child processes and is set as the GITHUB_ENV variable
# $1 key
# $2 value
function setEnv() {
  # Param
  local key=$1
  local value=$2
  # Declare global variables and export them
  declare -g "$key"="$value"
  export "$key"
  # SetEnv
  echo "$key=$value" >>$GITHUB_ENV
  # Return
  return 0
}
