#!/bin/sh

set -e

echo "Delete VM State on /tmp/vm-state-nixos-installer-machine"
rm -rf /tmp/vm-state-machine


TEST=$(nix-build ./tests/test.nix -A driver)
echo "VM-PATH: $TEST"
"$TEST/bin/nixos-run-vms"
echo "Done."
