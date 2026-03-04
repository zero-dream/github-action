#!/bin/bash
# Copyright (C) 2026 ZeroDream
# https://github.com/zero-dream

# --------------------------------------------------

# Tip: It will disrupt the Workflow initialization and execute at the end of the steps

# --------------------------------------------------

# Source
source "$ZD_LibPath/gitPush.sh"

# --------------------------------------------------

# Private
ZeroRepoPath="$RUNNER_TEMP/ZeroRepo-$(uuidgen | tr -d '-')"

# --------------------------------------------------

# CloneRepo
# echo path
function cloneRepo() {
  # CloneRepo
  git clone --depth=1 https://github.com/$GITHUB_REPOSITORY.git "$ZeroRepoPath/" || exit 1 # Exit
  # HandleGitDir
  rm -rf "$ZeroRepoPath/.git/"
  cp -a "$GITHUB_WORKSPACE/.git/" "$ZeroRepoPath/"
  # Return
  echo "$ZeroRepoPath"
  return 0
}

# PushRepo
# $1 commit
function pushRepo() {
  # Param
  local commit=$1
  # KeepDirArr
  local initCfgPath="$ZD_ConfigPath/init.json5"
  local initCfgJson=$(json5 "$initCfgPath")
  echo "$initCfgJson" | jq -r '.keepDirArr[]' | while read keepDir; do
    mkdir -p "$ZeroRepoPath/zerodream/$keepDir/"
    find "$ZeroRepoPath/zerodream/$keepDir/" -mindepth 1 -delete
    cp -a "$ZD_RootPath/$keepDir/." "$ZeroRepoPath/zerodream/$keepDir/"
  done
  # MergeRepo
  find "$GITHUB_WORKSPACE/" -mindepth 1 -delete
  cp -a "$ZeroRepoPath/." "$GITHUB_WORKSPACE/"
  # GitPush
  local currentBranch=$(git branch --show-current)
  gitPush "$currentBranch" "$commit"
  # DeleteRepo
  rm -rf "$ZeroRepoPath/"
  # Return
  return 0
}
