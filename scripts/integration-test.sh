#!/bin/bash
set -eu

BASE_DIR="$PWD"

cd app

# Make sure chromedriver is in the PATH
if ! type chromedriver >/dev/null 2>&1; then
  echo 'chromedriver: not found'
  echo
  echo 'Try running the following to install chromedriver:'
  echo 'npx @puppeteer/browsers install chromedriver@stable'
  echo
  echo 'Make sure to move the chromedriver binary to somewhere in your PATH'
  exit 1
fi

# Start chromedriver in the background
chromedriver \
  --port=4444 \
  --remote-debugging-pipe \
  --remote-debugging-port=9222 \
  &

# Kill chromedriver child process when we exit
trap 'kill 0' EXIT

# Run the integration tests using our own chromedriver
flutter drive \
  --no-pub \
  -d web-server \
  --target integration_test/main_test.dart \
  --no-headless \
  --web-browser-flag=--remote-debugging-port=9222
