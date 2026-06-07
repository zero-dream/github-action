#!/bin/bash
# Copyright (C) 2026 ZeroDream
# https://github.com/zero-dream

# --------------------------------------------------

# ScriptDir
ScriptDir=$(dirname "${BASH_SOURCE[0]}")

# --------------------------------------------------

# GitClone
workflowRepo="$ZD_Owner/github-action"
repoPath="$RUNNER_TEMP/ZeroWorkflowRepo-$(uuidgen | tr -d '-')" && mkdir -p "$repoPath"
git clone --depth=1 https://github.com/$workflowRepo.git "$repoPath/" || exit 1 # Exit

# KeepDirArr
initCfgPath="$ScriptDir/../../config/init.json5"
initCfgJson=$(json5 "$initCfgPath")
echo "$initCfgJson" | jq -r '.keepDirArr[]' | while read keepDir; do
  mkdir -p "$ZD_RootPath/$keepDir/"
  find "$repoPath/zerodream/$keepDir/" -mindepth 1 -delete
  cp -a "$ZD_RootPath/$keepDir/." "$repoPath/zerodream/$keepDir/"
done

# MergeRepo
find "$ZD_RootPath/" -mindepth 1 -delete
cp -a "$repoPath/zerodream/." "$ZD_RootPath/"
rm -rf "$repoPath/"

# --------------------------------------------------

exit 0
