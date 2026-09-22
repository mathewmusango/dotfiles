# scripts/checks (local check driver)

The entry point for the stage-1 checks: [`local.sh`](local.sh) runs the same checks CI runs, on this machine, before a push — and it is what the pre-commit hook execs.

```sh
scripts/checks/local.sh              # every surface whose files changed
scripts/checks/local.sh --full       # every surface, whole repository
scripts/checks/local.sh --full -v    # …and list the files each surface scans
scripts/checks/local.sh shell jsonc  # selected surfaces only
```

## Surfaces

| Surface | Checks |
| --- | --- |
| `jsonc` | `*.jsonc` parses, via [`jsonc.py`](jsonc.py) — plus that every `fastfetch/*/` design has both its `config.jsonc` and `screenshot.png` |
| `shell` | `shellcheck -S warning` across `*.sh` and `.githooks/` |
| `yaml-actionlint` | `actionlint` across `.github/workflows/` |
| `yaml-syntax` | every `*.yml` / `*.yaml` parses |

## How it runs

- **Diff-gated by default.** Changed files come from `origin/main...HEAD` plus the staged and unstaged working tree, then each surface's globs pick out the ones it owns. A surface with no matching files **skips** rather than runs — the same skip-model CI uses, so an irrelevant surface never blocks a commit.
- Each selected surface runs as a service from `container/checks/compose.yml` — images and commands are declared there, not here: see [`container/checks/`](../container/checks/README.md).
- The exit code is 0 only if every surface that actually ran passed.

## Running it another way

**Through podman** — the default, and what everything above describes. Each surface
executes as a compose service from [`container/checks/`](../container/checks/README.md),
so tool versions match CI exactly and nothing is installed on the host.

**Locally, if the tools are installed** — the equivalent commands, with no
containers. Handy for a quick single-tool run, but the versions are yours rather
than CI's, so a pass here is not proof that CI will pass:

| Surface | Local equivalent |
| --- | --- |
| `jsonc` | `python3 scripts/checks/jsonc.py` |
| `shell` | `shellcheck -S warning <files>` |
| `yaml-actionlint` | `actionlint` |
| `yaml-syntax` | `ruby -ryaml -e 'YAML.load_file(ARGV[0])' <file>` |

## Pre-commit hook

[`.githooks/pre-commit`](../.githooks/pre-commit) is a five-line shim that execs this driver, so the same checks run before every commit — diff-gated, over the staged changes. Enable it once per clone:

```sh
git config core.hooksPath .githooks
```

It runs the checks **through podman**, never with host tools, so a pass here means the same as a pass in CI. Bypass it deliberately with `git commit --no-verify` — CI still runs the full set, so that only defers the failure.

**`.githooks/` must hold only shell scripts.** The `shell` surface matches everything under that directory, so a README or any other non-shell file there makes `shellcheck` fail. That is why the hook has no README of its own and is documented here instead.

## Files

- `local.sh` — the driver (POSIX sh)
- `jsonc.py` — the JSONC parser backing the `jsonc` surface
