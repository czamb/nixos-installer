#!/bin/sh

set -e

# Define the dialog exit status codes
: "${DIALOG_OK=0}"
: "${DIALOG_CANCEL=1}"
: "${DIALOG_HELP=2}"
: "${DIALOG_EXTRA=3}"
: "${DIALOG_ITEM_HELP=4}"
: "${DIALOG_ESC=255}"

# Find possile locals
LOCALS=$(find "$(nix-build '<nixpkgs>' --no-out-link -A kbd)/share/keymaps" -type f -exec basename {} \; | sed 's/.map.gz//' | sort)

NUM_LOCALS=$( echo "$LOCALS" | wc -l)

DIALOG="dialog"

# Convert keyboard layout list to dialog readable list
LOCAL_OPT=""
for i in $LOCALS; do
    LOCAL_OPT="$LOCAL_OPT $i - off "
done

LOCAL_OPT="default - on $LOCAL_OPT"

echo "Num locals: $NUM_LOCALS"

# Duplicate file descriptor 1 on descriptor 3
exec 3>&1

# Select keyboard layout screen
result=$($DIALOG --title "Select Layout" --radiolist "Choose keyboard layout:" 0 0 "$NUM_LOCALS" $LOCAL_OPT 2>&1 1>&3)


if [ "$result" = "default" ]; then
    echo "Loadkeys -d"
    loadkeys -d
else
    echo "Loadkeys: $result"
    loadkeys "$result"
fi


