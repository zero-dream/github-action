#!/bin/bash
# Copyright (C) 2026 ZeroDream
# https://github.com/zero-dream

# --------------------------------------------------

# Dependence

# env.ZERO_LIB_REPO
# Jobs.Steps
#   current.env: GH_TOKEN: ${{secrets.WORKFLOW_TOKEN}}
# RepositoryPermissions (WORKFLOW_TOKEN):
#   Contents:  Read and Write
#   Workflows: Read and Write

# --------------------------------------------------

# GetLib
# $1 name
# echo path
function getLib() {
  # Param
  local name=$1
  # Check
  local libDir="$ZD_TempPath/library"
  local libPath="$libDir/$name"
  if [[ -f "$libPath" ]]; then
    # Return
    echo "$libPath"
    return 0
  fi
  # Download
  gh release download \
    --repo "$ZERO_LIB_REPO" \
    --pattern "$name" \
    --clobber \
    --dir "$libDir"
  if [[ $? -ne 0 ]]; then
    return 1
  fi
  # Chmod
  chmod +x "$libPath"
  # Return
  echo "$libPath"
  return 0
}
