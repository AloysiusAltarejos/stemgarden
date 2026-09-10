#!/bin/bash
cd -- "$(dirname -- "$0")" || exit 1
if ! command -v node >/dev/null 2>&1; then
  echo "Install Node.js LTS from https://nodejs.org/ then reopen this launcher."
  open 'https://nodejs.org/'
  read -r -p "Press Return to close."
  exit 1
fi
node scripts/launch.mjs
result=$?
if [ "$result" -ne 0 ]; then read -r -p "Press Return to close."; fi
exit "$result"
