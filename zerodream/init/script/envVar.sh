#!/bin/bash
# Copyright (C) 2026 ZeroDream
# https://github.com/zero-dream

# --------------------------------------------------

# Source
source "$InitDir/../script/setEnv.sh"
source "$InitDir/../script/createPath.sh"

# --------------------------------------------------

# ZDRootEnv
setEnv 'ZD_ScriptPath' "$ZD_RootPath/script"
setEnv 'ZD_ConfigPath' "$ZD_RootPath/config"
setEnv 'ZD_DataPath' "$ZD_RootPath/data"

# CIEnv
setEnv 'CI_ConfigPath' "$GITHUB_WORKSPACE/config"
setEnv 'CI_LibPath' "$GITHUB_WORKSPACE/library"
setEnv 'CI_ScriptPath' "$GITHUB_WORKSPACE/script"
setEnv 'CI_StoragePath' "$GITHUB_WORKSPACE/storage"

# --------------------------------------------------

# UploadReleasePath
releaseUploadPath=$(createTempPath 'ZeroReleaseUpload:dir')
setEnv 'ZD_ReleaseUploadPath' "$releaseUploadPath"

# UploadArtifactPath
artifactUploadPath=$(createTempPath 'ZeroArtifactUpload:dir')
setEnv 'ZD_ArtifactUploadPath' "$artifactUploadPath"

# --------------------------------------------------

return 0
