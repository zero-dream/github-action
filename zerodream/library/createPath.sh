#!/bin/bash
# Copyright (C) 2026 ZeroDream
# https://github.com/zero-dream

# --------------------------------------------------

# Usage:
# 01: createTempPath 'path/test:dir'
# 02: createTempPath 'path/test:file'

# CreateTempPath
# $1 string
function createTempPath() {
  # Param
  local string=$1
  # CreatePath
  createPath "$ZD_TempPath" "$string"
  # Return
  return $?
}

# CreatePath
# $1 root
# $2 string
# echo path
function createPath() {
  # Param
  local root=$1
  local string=$2
  # CreatePath
  local name="${string%:*}"
  local type="${string##*:}"
  local path="$root/$name"
  if [[ "$type" == 'dir' ]]; then
    mkdir -p "$path"
  elif [[ "$type" == 'file' ]]; then
    touch "$path"
  else
    return 1
  fi
  # Return
  echo "$path"
  return 0
}
