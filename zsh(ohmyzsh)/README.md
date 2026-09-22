# Zsh(ohmyzsh) Config

**[`Ohmyzsh`](https://github.com/ohmyzsh/ohmyzsh)** + **[`Powerlevel10k`](https://github.com/romkatv/powerlevel10k)**, with **[`Fastfetch`](../fastfetch/README.md)** on startup.

**Plugins:**

- git
- podman
- autocomplete
- autosuggestions
- history-substring-search
- syntax-highlighting

The `podman` plugin only adds aliases — install the [`podman`](../podman/README.md) package for it to do anything.

### Setup

**1. Install zsh, git, curl** (git + curl are prerequisites for the Oh My Zsh installer)

```sh
# Arch
yay -S zsh git curl
# Debian/Ubuntu
sudo apt install zsh git curl
# Fedora
sudo dnf install zsh git curl
```

> **Note — Nerd Font:** the p10k prompt needs a Nerd Font, or its icons render as `□`. Install and select **MesloLGS NF** — see the [`nerd-font`](../nerd-font/README.md) module.
>
> **yay** is an AUR helper for Arch — see the [`yay`](../yay/README.md) module.

**2. Make zsh the default shell**

```sh
chsh -s "$(which zsh)"
```

Log out/in (or `exec zsh` for the session).

**3. Install Oh My Zsh**

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Installs to `~/.oh-my-zsh` and creates a starter `~/.zshrc` (backs up an existing one).

**4. Install powerlevel10k**

```sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

**5. Install the plugins** (`git` and `podman` are built into Oh My Zsh):

```sh
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions        ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting    ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/marlonrichert/zsh-autocomplete        ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete
```

**6. Install this config** — replaces the starter `~/.zshrc` from step 3 with this repo's wired-up one, and installs the ready-made `~/.p10k.zsh` prompt (`.zshrc` sources it automatically). The theme and plugins from steps 4–5 live in `~/.oh-my-zsh/custom/` and are **not** touched. (Already have this repo? Just run this step.)

```sh
./zsh(ohmyzsh)/install.sh        # copies .zshrc + .p10k.zsh -> ~/ (no symlinks)
```

**7. Load the prompt**

```sh
exec zsh
```

To re-customize the prompt later, run `p10k configure` (interactive wizard) — it rewrites `~/.p10k.zsh`; re-run `install.sh` to restore the repo version.

### SSH agent

`.zshrc` exports `SSH_AUTH_SOCK` for Arch's socket-activated agent (only when unset,
so it never clobbers another agent) — that is what lets `ssh-add` work. `ssh`/`git`
reach the agent through `IdentityAgent` regardless.

```sh
ssh-add ~/.ssh/id_ed25519_<label>   # once per boot — agent keys live in memory
```

### Screenshots

[![zsh prompt](screenshot.png)](screenshot.png)
