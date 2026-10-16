#!/bin/bash
# Copyright (C) 2026 ZeroDream
# https://github.com/zero-dream

# --------------------------------------------------

# Usage:
# mergePaths=('config/' 'library/' 'script/')
# mergeRepo 'zero-dream/RepoA' 'mergePaths'

# --------------------------------------------------

# MergeRepo
# $1 repository
# $2 ZeroMergePaths (ProhibitedValue: ZeroMergePaths)
function mergeRepo() {
  # Config
  local forbiddenPrefixes=('.git' 'hook' 'zerodream')
  # Param
  local repository=$1
  local -n ZeroMergePaths=$2
  # Check
  local path prefix
  for path in "${ZeroMergePaths[@]}"; do
     path="${path%/}"
    for prefix in "${forbiddenPrefixes[@]}"; do
      case "$path" in "$prefix" | "$prefix"/*)
        return 1
        ;;
      esac
    done
  done
  # MergeRepo
  local repoPath="$(mktemp -d "$RUNNER_TEMP/ZeroDream-MergeRepo-repo-XXXXXX")"
  local mergePath="$(mktemp -d "$RUNNER_TEMP/ZeroDream-MergeRepo-merge-XXXXXX")"
  # GitClone
  git clone --depth=1 https://github.com/$repository.git "$repoPath/" || exit 1 # Exit
  # MergeRepo
  local path
  for path in "${ZeroMergePaths[@]}"; do
    mkdir -p "$mergePath/$(dirname "$path")"
    cp -aT "$repoPath/$path" "$mergePath/$path"
  done
  cp -a "$GITHUB_WORKSPACE/." "$mergePath/"
  find "$GITHUB_WORKSPACE/" -mindepth 1 -delete
  cp -a "$mergePath/." "$GITHUB_WORKSPACE/"
  # DeleteRepo
  rm -rf "$repoPath/"
  rm -rf "$mergePath/"
  # Return
  return 0
}
