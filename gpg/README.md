# GPG

**The OpenPGP key that signs commits and tags.** No key material is in this repo — the
secret key stays in `~/.gnupg/private-keys-v1.d/` and the revocation certificate in
`openpgp-revocs.d/`; both are gitignored.

## Files

- `common.conf` — keyboxd backend (GnuPG 2.4): public keys in `public-keys.d/pubring.db`, no `pubring.kbx`
- `gpg-agent.conf` — pinentry + caching
- `install.sh` — copies both into `~/.gnupg` at mode `600`, backing up any file it would replace, then restarts the agent

> [!WARNING]
> `pinentry-timeout` in `gpg-agent.conf` is load-bearing: the ~60 s default expires mid-dialog, and key generation then fails with `Timeout`.

## Setup

**1. Install GnuPG** (2.4+ for keyboxd)

```sh
yay -S gnupg
```

**2. Install this config** *(optional)*

```sh
./gpg/install.sh
```

**3. Generate a key** — skip if you already have one. Its UID must be an email
**verified on your GitHub account**, or GitHub cannot attribute the signature.

```sh
gpg --full-generate-key                          # ECC (sign and certify) → Curve 25519
gpg --quick-gen-key "<name> <email>" ed25519 default never   # non-interactive equivalent
```

**4. Verify**

```sh
gpg --list-secret-keys --keyid-format=long   # key present
git log --show-signature -1                  # "Good signature from …"
```

More: [`GnuPG` manual](https://gnupg.org/documentation/manuals/gnupg/) · [GitHub: signing commits](https://docs.github.com/en/authentication/managing-commit-signature-verification)
