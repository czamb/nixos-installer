#!/bin/sh

# Define the dialog exit status codes
: "${DIALOG_OK=0}"
: "${DIALOG_CANCEL=1}"
: "${DIALOG_HELP=2}"
: "${DIALOG_EXTRA=3}"
: "${DIALOG_ITEM_HELP=4}"
: "${DIALOG_ESC=255}"

# Find possile locals
LOCALS=$(find "$(nix-build '<nixpkgs>' --no-out-link -A kbd)/share/keymaps" -type f -exec basename {} \; | sed 's/.map.gz//')

# Duplicate file descriptor 1 on descriptor 3
exec 3>&1

#test
result=$(dialog --title "INPUT BOX"   --clear    --inputbox "Username" 16 51 2>&1 1>&3)

echo "Result: $result"
