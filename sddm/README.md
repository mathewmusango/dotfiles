# SDDM

**Runs the login greeter on Wayland instead of X11** — no root Xorg process, which on a
hybrid-GPU laptop also stops the greeter from holding the discrete GPU open.

## Files

- [`10-wayland.conf`](10-wayland.conf) — sets `DisplayServer=wayland`
- [`install.sh`](install.sh) — copies it into `/etc/sddm.conf.d/` (root)

## Setup

**1. Install SDDM**

```sh
yay -S sddm
```

**2. Install the config**

```sh
sudo ./sddm/install.sh
```

**3. Verify** *(after a reboot)*

```sh
ps -C Xorg        # empty — the greeter no longer runs Xorg
```

More: [`SDDM`](https://wiki.archlinux.org/title/SDDM)
