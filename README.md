# dotfiles

**Personal configs, installed by copy — never by symlink.** Each app is a module:
config in the repo, an install script that copies it into place, and its own README —
or, where a module only documents a setup, just the README.

```text
dotfiles/
  ├── .githooks/            # pre-commit hook -> local checks
  ├── .github/              # checks.yml, codeql.yml, CODEOWNERS, dependabot
  ├── aws/                  # AWS CLI v2 via a pinned podman image
  ├── containers/checks/    # podman compose — one service per check
  ├── fastfetch/            # fastfetch designs: 01-minimal, 02-tree
  ├── git/                  # git itself (install notes)
  ├── gpg/                  # GnuPG agent config: common.conf, gpg-agent.conf
  ├── nerd-font/            # MesloLGS NF glyph font (install notes)
  ├── podman/               # rootless containers (install notes)
  ├── reflector/            # Arch mirrorlist configs + daily timer override
  ├── rulesets/             # main.json + its record — the live branch ruleset
  ├── scripts/checks/       # local.sh driver + jsonc.py parser
  ├── ssh/                  # SSH keys, host pinning and agent (docs only)
  ├── yay/                  # AUR helper (install notes)
  ├── zsh(ohmyzsh)/         # .zshrc + .p10k.zsh
  ├── CODE_OF_CONDUCT.md
  ├── CONTRIBUTING.md
  ├── LICENSE
  ├── README.md
  └── SECURITY.md
```

## Modules

| Module | Installs to | Installer |
|---|---|---|
| [`aws/`](aws/README.md) | `~/.local/bin/aws` | `./install.sh` |
| [`fastfetch/`](fastfetch/README.md) | `~/.config/fastfetch/config.jsonc` | `./replace.sh <design>` |
| [`git/`](git/README.md) | — install notes only | — |
| [`gpg/`](gpg/README.md) | `~/.gnupg/{common,gpg-agent}.conf` (overwrites) | `./install.sh` |
| [`nerd-font/`](nerd-font/README.md) | — install notes only | — |
| [`podman/`](podman/README.md) | — install notes only | — |
| [`reflector/`](reflector/README.md) | `/etc/xdg/reflector/` + `reflector.timer` override | `sudo ./install.sh` |
| [`ssh/`](ssh/README.md) | — SSH keys, host pinning, agent (nothing installed) | — |
| [`yay/`](yay/README.md) | — install notes only | — |
| [`zsh(ohmyzsh)/`](zsh(ohmyzsh)/README.md) | `~/.zshrc`, `~/.p10k.zsh` (overwrites) | `./install.sh` |

> [!WARNING]
> `gpg/` and `zsh(ohmyzsh)/` install over files that already exist at their destination.

The `02-tree` design and the p10k prompt need a Nerd Font — see [`nerd-font/`](nerd-font/README.md).

## Repository docs

Every module's README is linked in the table above. The rest of the documentation:

| Doc | Covers |
| --- | --- |
| [`.github/`](.github/INDEX.md) | the repository configuration — Dependabot, CodeQL, CODEOWNERS — and where each security surface acts |
| [`.github/workflows/`](.github/workflows/README.md) | every workflow — its triggers, the checks it reports, and the local parity stack |
| [`rulesets/`](rulesets/README.md) | the branch ruleset, and the record beside it |
| [`containers/checks/`](containers/checks/README.md) | the compose services behind the checks |
| [`scripts/checks/`](scripts/checks/README.md) | the check driver and the pre-commit hook — run the surfaces, or the same tools locally |
| [`CONTRIBUTING.md`](CONTRIBUTING.md) · [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md) | who changes this, and the standard for any interaction |

## Setup

```sh
gh repo clone mathewmusango/dotfiles && cd dotfiles
```

Then follow the module README you need.

## Security

Report privately — see [SECURITY.md](SECURITY.md).

## License

MIT — see [LICENSE](LICENSE).
