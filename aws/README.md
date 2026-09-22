# aws (AWS CLI v2)

The [AWS CLI](https://aws.amazon.com/cli/) v2, run from a pinned container image instead of a host package — so the CLI version is decoupled from the distro and nothing AWS-related is installed system-wide.

> **Why a container?** The Agent Toolkit for AWS needs **CLI 2.35 or newer**, while Arch's `extra` repo still ships 2.34.x. Running the official [`amazon/aws-cli`](https://hub.docker.com/r/amazon/aws-cli) image supplies the required version without shadowing the distro package with a second host install. `--network host` is used because rootless pasta networking can fail, and `~/.aws` is mounted so the container sees the same profiles.

## Files

- `aws` — the wrapper: `podman run` against the pinned image, defaulting to a read-only profile
- `install.sh` — copies the wrapper to `~/.local/bin/aws` and pulls the image

## Setup

**1. Prerequisites** — [podman](../podman/README.md), plus a profile in `~/.aws`

```sh
yay -S podman
```

**2. Install the wrapper**

```sh
./install.sh
```

**3. Verify**

```sh
aws --version
aws sts get-caller-identity
```

`~/.local/bin` has to precede `/usr/bin` on `PATH` — confirm with `command -v aws`.

## Notes

- The default profile is `readonly`; `AWS_PROFILE` or an explicit `--profile` overrides it.
- Each call starts a container, so expect a short startup delay.
- Credentials stay in `~/.aws`; the wrapper stores none of its own.
- Pin the image to a release tag rather than `latest`, so behaviour stays reproducible.
- Companion piece: the Agent Toolkit's MCP server, wired into the editor separately.

Upstream: <https://docs.aws.amazon.com/cli/> · image: <https://hub.docker.com/r/amazon/aws-cli>
