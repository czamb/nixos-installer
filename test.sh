#!/bin/sh

set -e 

TEST=$(nix-build ./tests/test.nix -A driver)
echo "VM-PATH: $TEST"
"$TEST/bin/nixos-run-vms"
echo "Done."
