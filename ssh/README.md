# SSH

**How keys are pinned to hosts and unlocked here.** No key material and no inventory
is in this repo — private keys stay in `~/.ssh/`, and this repo is public.

## Host pinning — `~/.ssh/config`

```sshconfig
# Global block FIRST — ssh keeps the first value it obtains for each option.
Host *
  AddKeysToAgent yes
  IdentityAgent <absolute path to the agent socket>

# One block per host, each pinned to the key that host uses.
Host <host>
  HostName <host>
  User git
  IdentityFile ~/.ssh/id_ed25519_<label>
  IdentitiesOnly yes
```

## Agent

Arch's agent is **socket-activated** (`ssh-agent.socket`). `ssh`/`scp`/`git` reach it
through `IdentityAgent`; **`ssh-add` and agent forwarding need `SSH_AUTH_SOCK`**,
exported by the [`zsh`](../zsh(ohmyzsh)/README.md) module.

```sh
ssh-add ~/.ssh/id_ed25519_<label>   # once per boot — agent keys live in memory
```

## Keys

```sh
ssh-keygen -l -f ~/.ssh/id_ed25519_<label>        # fingerprint
ssh-keygen -p -f ~/.ssh/id_ed25519_<label>        # add/change a passphrase
ssh -T git@github.com                             # end to end: "Hi <user>!…"
```

A passphrase does not change the public key, so host registrations and the pins above
keep working. Retiring a key means adding its replacement on every host **first** —
deleting the local file does not revoke it.

More: [`ssh_config(5)`](https://man.openbsd.org/ssh_config) · [GitHub: connecting with SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
