# Reflector

**Auto-updates the mirrorlist daily** — rate-sorted HTTPS mirrors, so updates stay fast.

## Files

- `override.conf` — timer override: clears the stock weekly schedule, runs reflector **daily**
- `reflector.conf` — mirror filters: save to `/etc/pacman.d/mirrorlist`, HTTPS only, 5 latest, sort by rate
- `install.sh` — copies both into `/etc` and enables the timer (root)

## Setup

**1. Install reflector**

```sh
yay -S reflector
```

**2. Install configs + enable the daily timer**

```sh
sudo ./reflector/install.sh
```

**3. Verify**

```sh
systemctl list-timers reflector.timer
```

More: [`Reflector`](https://wiki.archlinux.org/title/Reflector)
