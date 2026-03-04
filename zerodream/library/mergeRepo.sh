#!/bin/bash
# Copyright (C) 2026 ZeroDream
# https://github.com/zero-dream

# --------------------------------------------------

# MergeSort: zero-dream/github-action > $GITHUB_REPOSITORY > RepoA > RepoB

# --------------------------------------------------

# Usage:
# mergeArr=('zero-dream/RepoA' 'zero-dream/RepoB')
# mergeRepo 'mergeArr'

# MergeRepo
# $1 ZeroMergeArr MergeArr (ProhibitedValue: ZeroMergeArr)
function mergeRepo() {
  # Param
  local -n ZeroMergeArr=$1
  # MergeRepo
  local repoPath="$RUNNER_TEMP/ZeroDreamRepo-$(uuidgen | tr -d '-')"
  for repository in "${ZeroMergeArr[@]}"; do
    local repoName=$(echo -n "$repository" | md5sum | awk '{print $1}')
    # GitClone
    git clone --depth=1 https://github.com/$repository.git "$repoPath/$repoName/" || exit 1 # Exit
    # DeleteDir
    rm -rf "$repoPath/$repoName/.git/"      # DeleteGitDir
    rm -rf "$repoPath/$repoName/hook/"      # DeleteHookDir
    rm -rf "$repoPath/$repoName/zerodream/" # DeleteZeroDreamDir
    # MergeRepo
    cp -a "$GITHUB_WORKSPACE/." "$repoPath/$repoName/"
    find "$GITHUB_WORKSPACE/" -mindepth 1 -delete
    cp -a "$repoPath/$repoName/." "$GITHUB_WORKSPACE/"
    # DeleteRepo
    rm -rf "$repoPath/$repoName/"
  done
  # Return
  return 0
}
