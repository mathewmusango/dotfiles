# dotfiles

**Personal configs, installed by copy — never by symlink.** Each app is a module:
config in the repo, an install script that copies it into place, and its own README.

```text
dotfiles/
  ├── .githooks/            # pre-commit hook -> local checks
  ├── .github/              # checks.yml, CODEOWNERS, dependabot
  ├── container/checks/     # podman compose — one service per check
  ├── fastfetch/            # fastfetch designs: 01-minimal, 02-tree
  ├── reflector/            # Arch mirrorlist configs + daily timer override
  ├── scripts/checks/       # local.sh driver + jsonc.py parser
  ├── yay/                  # AUR helper (install notes)
  ├── zsh(ohmyzsh)/         # .zshrc + .p10k.zsh
  ├── LICENSE
  ├── README.md
  └── SECURITY.md
```

## Modules

| Module | Installs to | Installer |
|---|---|---|
| [`fastfetch/`](fastfetch/README.md) | `~/.config/fastfetch/config.jsonc` | `./replace.sh <design>` |
| [`zsh(ohmyzsh)/`](zsh(ohmyzsh)/README.md) | `~/.zshrc`, `~/.p10k.zsh` (overwrites) | `./install.sh` |
| [`reflector/`](reflector/README.md) | `/etc/xdg/reflector/` + `reflector.timer` override | `sudo ./install.sh` |
| [`yay/`](yay/README.md) | — install notes only | — |

The `02-tree` design and the p10k prompt need a Nerd Font (MesloLGS NF).

## Setup

```sh
gh repo clone mathewmusango/dotfiles && cd dotfiles
```

Then follow the module README you need.

## Security

Report privately — see [SECURITY.md](SECURITY.md).

## License

MIT — see [LICENSE](LICENSE).
