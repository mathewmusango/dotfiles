#!/usr/bin/env sh
# Install the repo's SDDM config: run the greeter on Wayland instead of X11.
# Run with sudo. Backs up any destination it would change (no symlinks).
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"

if [ "$(id -u)" -ne 0 ]; then
    echo "error: run with sudo — this writes to /etc/sddm.conf.d" >&2
    exit 1
fi

dest=/etc/sddm.conf.d/10-wayland.conf
if [ -e "$dest" ] && ! cmp -s "$DIR/10-wayland.conf" "$dest"; then
    cp -p "$dest" "$dest.bak"
    echo "backed up $dest -> $dest.bak"
fi

install -Dm644 "$DIR/10-wayland.conf" "$dest"
echo "installed $DIR/10-wayland.conf -> $dest"
