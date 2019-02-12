#!/bin/sh

TEST=$(nix-build ./tests/test.nix)
firefox "$TEST/log.html"
# echo "VM-PATH: $TEST"
# exec "$TEST/bin/nixos-test-driver "
