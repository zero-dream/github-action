#!/bin/bash
# Copyright (C) 2026 ZeroDream
# https://github.com/zero-dream

# --------------------------------------------------

# InitDir
InitDir=$(dirname "${BASH_SOURCE[0]}")

# Source
source "$InitDir/../library/setEnv.sh"

# --------------------------------------------------

# ZDEnv
setEnv 'ZD_Owner' 'zero-dream'
setEnv 'ZD_DateUTC' "$(TZ=UTC date '+%y%m%d%H%M%S')"
setEnv 'ZD_RootPath' "$GITHUB_WORKSPACE/zerodream"
setEnv 'ZD_HookPath' "$GITHUB_WORKSPACE/hook"
setEnv 'ZD_TempPath' "$ZD_RootPath/temp" && mkdir -p "$ZD_TempPath"

# --------------------------------------------------

# ZeroDreamCore
bash "$InitDir/script/initEnv.sh"
bash "$InitDir/script/mergeRepo.sh"
source "$InitDir/script/envVar.sh"
bash "$InitDir/script/check.sh"

# --------------------------------------------------

# Must, otherwise the status code will be that of the previous command
exit 0
