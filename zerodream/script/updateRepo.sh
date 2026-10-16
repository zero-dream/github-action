#!/bin/bash
# Copyright (C) 2026 ZeroDream
# https://github.com/zero-dream

# --------------------------------------------------

# Tip: It will disrupt the Workflow initialization and execute at the end of the steps

# --------------------------------------------------

# Dependence

# script/gitPush.sh

# --------------------------------------------------

# Source
source "$ZD_ScriptPath/gitPush.sh"

# --------------------------------------------------

# Variable
Zero_TempRepoPath="$(mktemp -d "$RUNNER_TEMP/ZeroDream-UpdateRepo-XXXXXX")"

# --------------------------------------------------

# CloneRepo
# echo path
function cloneRepo() {
  # CloneRepo
  git clone --depth=1 https://github.com/$GITHUB_REPOSITORY.git "$Zero_TempRepoPath/" || exit 1 # Exit
  # HandleGitDir
  rm -rf "$Zero_TempRepoPath/.git/"
  cp -a "$GITHUB_WORKSPACE/.git/" "$Zero_TempRepoPath/"
  # Return
  echo "$Zero_TempRepoPath"
  return 0
}

# PushRepo
# $1 message
function pushRepo() {
  # Param
  local message=$1
  # KeepDirArr
  local initCfgPath="$ZD_ConfigPath/init.json5"
  local initCfgJson=$(json5 "$initCfgPath")
  echo "$initCfgJson" | jq -r '.keepDirArr[]' | while read keepDir; do
    mkdir -p "$Zero_TempRepoPath/zerodream/$keepDir/"
    find "$Zero_TempRepoPath/zerodream/$keepDir/" -mindepth 1 -delete
    cp -a "$ZD_RootPath/$keepDir/." "$Zero_TempRepoPath/zerodream/$keepDir/"
  done
  # MergeRepo
  find "$GITHUB_WORKSPACE/" -mindepth 1 -delete
  cp -a "$Zero_TempRepoPath/." "$GITHUB_WORKSPACE/"
  # GitPush
  local ref=$(git branch --show-current)
  gitPush "$ref" "$message"
  # DeleteRepo
  rm -rf "$Zero_TempRepoPath/"
  # Return
  return 0
}
