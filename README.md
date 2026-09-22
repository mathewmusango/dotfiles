# dotfiles

**Personal configs, installed by copy — never by symlink.** Each app is a module:
config in the repo, an install script that copies it into place, and its own README —
or, where a module only documents a setup, just the README.

```text
dotfiles/
  ├── .githooks/            # pre-commit hook -> local checks
  ├── .github/              # checks.yml, CODEOWNERS, dependabot
  ├── aws/                  # AWS CLI v2 via a pinned podman image
  ├── container/checks/     # podman compose — one service per check
  ├── fastfetch/            # fastfetch designs: 01-minimal, 02-tree
  ├── gpg/                  # GnuPG agent config: common.conf, gpg-agent.conf
  ├── reflector/            # Arch mirrorlist configs + daily timer override
  ├── rulesets/             # main.json — a record of the live branch ruleset
  ├── scripts/checks/       # local.sh driver + jsonc.py parser
  ├── ssh/                  # SSH keys, host pinning and agent (docs only)
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
| [`ssh/`](ssh/README.md) | — SSH keys, host pinning, agent (nothing installed) | — |
| [`gpg/`](gpg/README.md) | `~/.gnupg/{common,gpg-agent}.conf` (overwrites) | `./install.sh` |
| [`aws/`](aws/README.md) | `~/.local/bin/aws` | `./install.sh` |

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
