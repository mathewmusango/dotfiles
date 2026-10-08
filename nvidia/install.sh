#!/usr/bin/env sh
# Install the repo's NVIDIA hybrid-graphics power config:
#   /etc/modprobe.d/nvidia-pm.conf         driver options (runtime PM + KMS)
#   /etc/udev/rules.d/80-nvidia-pm.rules   runtime PM for the NVIDIA PCI devices
# Run with sudo. Backs up any destination it would change (no symlinks).
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"

if [ "$(id -u)" -ne 0 ]; then
    echo "error: run with sudo — this writes to /etc" >&2
    exit 1
fi

install_cfg() {
    src="$1"; dest="$2"
    if [ -e "$dest" ] && ! cmp -s "$src" "$dest"; then
        cp -p "$dest" "$dest.bak"
        echo "backed up $dest -> $dest.bak"
    fi
    install -Dm644 "$src" "$dest"
    echo "installed $src -> $dest"
}

install_cfg "$DIR/nvidia-pm.conf"     /etc/modprobe.d/nvidia-pm.conf
install_cfg "$DIR/80-nvidia-pm.rules" /etc/udev/rules.d/80-nvidia-pm.rules

udevadm control --reload
udevadm trigger --subsystem-match=pci
echo "done — add the nvidia modules to mkinitcpio MODULES, then reboot"
