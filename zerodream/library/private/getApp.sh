#!/bin/bash
# Copyright (C) 2026 ZeroDream
# https://github.com/zero-dream

# --------------------------------------------------

# Dependence

# Jobs.Steps
#   current.env: GH_TOKEN: ${{secrets.WORKFLOW_TOKEN}}
# RepositoryPermissions (WORKFLOW_TOKEN):
#   Contents:  Read and Write
#   Workflows: Read and Write

# --------------------------------------------------

# GetApp
# $1 name
function getApp() {
  # Param
  local name=$1
  # RunApp
  local appPath="$ZD_TempPath/application/$name"
  if [[ -f "$appPath" ]]; then
    echo "$appPath"
    return 0
  fi
  # Download
  gh release download \
    --repo 'zero-dream/github-application' \
    --pattern "$name" \
    --clobber \
    --dir "$ZD_TempPath/application"
  if [[ $? -ne 0 ]]; then
    return 1
  fi
  # RunApp
  chmod +x "$appPath"
  echo "$appPath"
  return 0
}
