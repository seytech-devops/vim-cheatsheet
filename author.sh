#!/usr/bin/env bash
set -exo pipefail

# Simple note-taking script
# Author: Aziz Niiazbekov

# get the date
date=$(date)

# get the topic
topic=$1


# filename to write to
filename="${HOME}/lab/${topic}notes.txt"


# Ask user for input
read -p "Your note:" note

if [[ $note ]]; then
  echo "$(date): $note" >> "$filename"
  echo "Note '$note' saved to $filename"
else
  echo "no input; note wasn't saved"
fi
