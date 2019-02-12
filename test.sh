#!/bin/sh

TEST=$(nix-build ./tests/test.nix)
echo "VM-PATH: $TEST"
exec "$TEST/bin/nixos-test-driver "
