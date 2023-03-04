#!/usr/bin/env bash

# this script is just a test
set -xeuo pipefail

source="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"



timestamp="$(date "+%a %b %e %H:%M:%S")"

echo ${timestamp}

if [[ $? -eq 0 ]]; then
  echo "Yay, success exit code is always good!"
else
  exit 1
fi
