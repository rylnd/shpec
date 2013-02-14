#!/usr/bin/env shpec
. process.sh

describe "unicorn_rails worker"
  it
    should have_process_count 8
end_describe
