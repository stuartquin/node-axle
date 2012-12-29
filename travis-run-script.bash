#!/usr/bin/env bash
set -e

export NODE_ENV=test
export MY_TWERP_OPTIONS="--exit-on-failure --runner=simple"

# only output anything if a command fails
function silence-or-loud-on-error {
  output=$(${@} 2>&1)

  if [[ ${?} != 0 ]]; then
    echo "${output}"
  fi
}

# cant do proxy yet because of the tests that rely on host files being
# set.
silence-or-loud-on-error npm install
twerp test/axle.coffee
