# nerd-font (MesloLGS NF)

A [Nerd Font](https://www.nerdfonts.com/) — a patched font carrying the extra glyphs that powerline prompts and TUI tools draw their icons from. This module covers **MesloLGS NF**, the font [Powerlevel10k](https://github.com/romkatv/powerlevel10k) is designed around.

> **Why it matters?** Without a Nerd Font the p10k prompt and the fastfetch designs render their icons as `□`. Installing the font is only half the job — the terminal emulator has to be told to use it.

## Install

**1. Install the font**

```sh
# Arch
yay -S ttf-meslo-nerd-font-powerlevel10k
```

Debian/Ubuntu and Fedora ship no package — download the four TTFs into the user font directory:

```sh
mkdir -p ~/.local/share/fonts
curl -fLo ~/.local/share/fonts/MesloLGS\ NF\ Regular.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
curl -fLo ~/.local/share/fonts/MesloLGS\ NF\ Bold.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
curl -fLo ~/.local/share/fonts/MesloLGS\ NF\ Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
curl -fLo ~/.local/share/fonts/MesloLGS\ NF\ Bold\ Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
fc-cache -f ~/.local/share/fonts
```

**2. Select it in the terminal**

Set the font family to **MesloLGS NF** in the terminal emulator's own config.

**3. Verify**

```sh
fc-list | grep -i meslo
```

The prompt's icons should now render as glyphs rather than boxes.

## Notes

- The font is set **per terminal emulator** — there is no system-wide default.
- Any Nerd Font works; MesloLGS NF is simply the one p10k is tuned for.
- Required by [`zsh(ohmyzsh)/`](../zsh(ohmyzsh)/README.md) (the p10k prompt) and [`fastfetch/`](../fastfetch/README.md) (design icons).

Upstream: <https://github.com/romkatv/powerlevel10k#fonts>
