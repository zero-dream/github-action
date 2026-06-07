#!/bin/bash
# Copyright (C) 2026 ZeroDream
# https://github.com/zero-dream

# --------------------------------------------------

# CheckScript
[[ -d "$GITHUB_WORKSPACE/" ]] && find "$GITHUB_WORKSPACE/" -type f \
  -iregex ".*\.\(sh\|hook\)$" \
  -exec chmod +x {} \;

# CheckScript
scriptDirs=(
  "$ZD_RootPath/library/"
)
for scriptDir in "${scriptDirs[@]}"; do
  [[ -d "$scriptDir/" ]] && find "$scriptDir/" -type f \
    ! -name '.gitkeep' \
    -exec chmod +x {} \;
done

# --------------------------------------------------

exit 0
