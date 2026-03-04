#!/bin/bash
# Copyright (C) 2026 ZeroDream
# https://github.com/zero-dream

# --------------------------------------------------

# CheckScript
[[ -d "$GITHUB_WORKSPACE/" ]] && find "$GITHUB_WORKSPACE/" -type f \
  -iregex ".*\.\(sh\|hook\)$" \
  -exec chmod +x {} \;

# CheckDirs
dirs=(
  "$ZD_RootPath/library/"
  "$CI_AppPath/"
)
for dir in "${dirs[@]}"; do
  [[ -d "$dir/" ]] && find "$dir/" -type f \
    ! -name '.gitkeep' \
    -exec chmod +x {} \;
done

# --------------------------------------------------

exit 0
