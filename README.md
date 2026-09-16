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
  ├── rulesets/             # main.json — a record of the live branch ruleset
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

## Checks and pull requests

CI is one workflow, [`checks.yml`](.github/workflows/checks.yml), which calls the
shared reusables in [`mathewmusango/my-workflows`](https://github.com/mathewmusango/my-workflows)
pinned to a full commit SHA. It runs on **pull requests into `main`** (plus manual
dispatch) — nothing runs on a push, so a bypass push by the owner is unchecked and
the PR is the single gate. Each reusable self-gates, so an untouched surface
**skips and reports success**, which is what lets a ruleset require them all without
blocking unrelated PRs.

`main` is protected by a ruleset, recorded verbatim in
[`rulesets/main.json`](rulesets/main.json) (the file is a read-out of the live
ruleset, not its source — apply changes in Settings → Rules):

- **Pull request required** — 1 approving review, stale reviews dismissed on push,
  review threads must be resolved, squash/rebase merges only.
- **Required status checks** (strict: the branch must be up to date):
  `jsonc / jsonc` · `shell / shellcheck` · `yaml / syntax` · `yaml / actionlint` ·
  `secrets / gitleaks`. The `deps / dependency-review` job exists on every PR but is
  deliberately **not required yet** — a check name can only be required once a run
  has actually reported it.
- **Force-push and branch deletion blocked.**
- **Admin bypass** (`RepositoryRole: admin`, always) — the owner can still push
  straight to `main`; everything else goes through a PR.

> The check names are the ones GitHub actually reports for a reusable call:
> `<caller job> / <leaf job>`. Note the asymmetry for a job gated at the **caller**
> level: when it skips, GitHub reports the bare caller key — a push run checks in as
> `deps`, while on a pull request its leaf runs and reports `deps / dependency-review`.
> Requiring a name no run reports leaves a PR stuck on "Expected — waiting for status
> to be reported": check with
> `gh api repos/<owner>/<repo>/commits/<sha>/check-runs` before adding one.

## Security

Report privately — see [SECURITY.md](SECURITY.md).

## License

MIT — see [LICENSE](LICENSE).
