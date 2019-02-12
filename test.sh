#!/bin/sh

TEST=$(nix-build ./tests/test.nix -A driver)
echo "VM-PATH: $TEST"
exec "$TEST/bin/nixos-run-vms"
