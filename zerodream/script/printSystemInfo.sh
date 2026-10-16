#!/bin/bash
# Copyright (C) 2026 ZeroDream
# https://github.com/zero-dream

# --------------------------------------------------

# Usage:
# printSystemInfo
# printSystemInfo 'all'
# printSystemInfo 'df du'

# --------------------------------------------------

systemInfoArr=(
  "cpu printCPUInfo"
  "df printDiskFreeInfo"
  "du printDiskUsageInfo"
  "dpkg printDpkgInfo"
)

# PrintCPUInfo
function printCPUInfo() {
  # PrintInfo
  echo "$(printf -- '-%.0s' {1..50})"
  echo '# CPU Info'
  local patterns=(
    '^Architecture:'
    '^CPU op-mode\(s\):'
    '^CPU\(s\):'
    '^On-line CPU\(s\) list:'
    '^Vendor ID:'
    '^Model name:'
    'CPU\(s\) scaling MHz:'
    '^BogoMIPS:'
  )
  local args=()
  local pattern
  for pattern in "${patterns[@]}"; do
    args+=(-e "$pattern")
  done
  lscpu | grep -E "${args[@]}"
  # Return
  return 0
}

# PrintDiskFreeInfo
function printDiskFreeInfo() {
  # PrintInfo
  echo "$(printf -- '-%.0s' {1..50})"
  echo '# Disk Free Info'
  df -h
  # Return
  return 0
}

# PrintDiskUsageInfo
function printDiskUsageInfo() {
  # PrintInfo
  echo "$(printf -- '-%.0s' {1..50})"
  echo '# Disk Usage Info'
  du -h --max-depth=1
  # Return
  return 0
}

# PrintDpkgInfo
function printDpkgInfo() {
  # PrintInfo
  echo "$(printf -- '-%.0s' {1..50})"
  echo '# Dpkg Info'
  dpkg-query -W -f='[${db:Status-Status}] ${Package} ${Version} ${Architecture}\n'
  # Return
  return 0
}

# PrintSystemInfo
# $1 keys
function printSystemInfo() {
  # Param
  local keys=${1:-all}
  # SeparatorLine
  echo "$(printf -- '=%.0s' {1..50})"
  echo '# System Info'
  # PrintInfo
  if [[ "$keys" == "all" ]]; then
    local info infoFunc
    for info in "${systemInfoArr[@]}"; do
      infoFunc=${info##* }
      "$infoFunc"
    done
  else
    local key info infoKey infoFunc
    for key in $keys; do
      for info in "${systemInfoArr[@]}"; do
        infoKey=${info%% *}
        infoFunc=${info##* }
        if [[ "$key" == "$infoKey" ]]; then
          "$infoFunc"
          break
        fi
      done
    done
  fi
  # SeparatorLine
  echo "$(printf -- '=%.0s' {1..50})"
  # Return
  return 0
}
