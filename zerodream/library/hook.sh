#!/bin/bash
# Copyright (C) 2026 ZeroDream
# https://github.com/zero-dream

# --------------------------------------------------

# About $scriptPath.hook
# exit 0 # CurrentStep: continue; BehindStep continue
# exit 1 # CurrentStep: stop; BehindStep continue
# exit 2 # CurrentStep: stop; BehindStep stop

# Hook
# $1 scriptPath
# echo message
function hook() {
  # Param
  local scriptPath=$1
  # Hook
  local hookPath="$ZD_HookPath/$scriptPath.hook"
  echo '--------------------------------------------------'
  echo "Hook: $hookPath"
  if [[ ! -f "$hookPath" ]]; then
    echo 'Warning: Hook does not exist'
    echo '--------------------------------------------------'
    return 0
  fi
  bash "$hookPath"
  local state=$?
  echo "State: $state"
  echo '--------------------------------------------------'
  (($state == 1)) && exit 0
  (($state == 2)) && exit 1
  # Must, otherwise the status code will be that of the previous command
  return 0
}
