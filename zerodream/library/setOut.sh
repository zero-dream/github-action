#!/bin/bash
# Copyright (C) 2026 ZeroDream
# https://github.com/zero-dream

# --------------------------------------------------

# SetOut
# The variable is accessible to the current process and child processes and is set as the GITHUB_OUTPUT variable
# $1 key
# $2 value
function setOut() {
  # Param
  local key=$1
  local value=$2
  # Declare global variables and export them
  declare -g "$key"="$value"
  export "$key"
  # SetOut
  echo "$key=$value" >>$GITHUB_OUTPUT
  # Return
  return 0
}
