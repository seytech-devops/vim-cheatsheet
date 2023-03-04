#!/usr/bin/env bash

#Find the min number in range of this random/arbitrary numbers: 2, 4, 5, 3, 6, 9
set -xeuo pipefail

ARRAY=(2 4 5 3 6 9)

printf '%s\n' "${ARRAY[@]}"| sort -n

#you can add sort -r option for recursive loop. From max --> min
#or use -V for version sort.
