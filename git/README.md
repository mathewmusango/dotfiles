# git

[`Git`](https://git-scm.com/) — the version control system this repository is stored in. It is a **prerequisite** rather than a config: nothing is set up here beyond the tool itself, and identity, signing and transport belong to other modules.

> **Why it matters here?** Nearly every other module needs it — the [`yay`](../yay/README.md) bootstrap builds from source, the [`zsh(ohmyzsh)`](../zsh(ohmyzsh)/README.md) installer clones Oh My Zsh, and [`fastfetch`](../fastfetch/README.md) clones this repo to copy a design.

## Install

**1. Install git** — skip if `git --version` already works

```sh
# Arch
yay -S git
# Debian/Ubuntu
sudo apt install git
# Fedora
sudo dnf install git
```

**2. Verify**

```sh
git --version
```

## Notes

- Identity is not installed here: set `user.name` and `user.email` before your first commit, using the address your Git host knows, or commits arrive unattributed.
- Signed commits need a key from the [`gpg`](../gpg/README.md) module; pushing over SSH needs the key setup in the [`ssh`](../ssh/README.md) module.
- `gh` (GitHub CLI) is a separate tool, not covered here — some modules clone this repo with `gh repo clone`.

Upstream: <https://git-scm.com/doc>
