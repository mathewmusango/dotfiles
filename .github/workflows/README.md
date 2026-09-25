# Workflows

## Naming

- One purpose per file, named for the task — `checks.yml`, `codeql.yml`. A second file for the same kind of job takes `{task}-{language|resource}`.
- Display names are quoted: an unquoted colon+space is invalid YAML.
- The ruleset that requires the reported checks is in [`rulesets/`](../../rulesets/README.md); the rest of `.github/` is indexed in [`.github/`](../INDEX.md).

## `checks.yml`

- Pull requests to `main`, plus manual dispatch. One caller job per surface, each calling a reusable workflow in `mathewmusango/my-workflows`, SHA-pinned with the tag in a trailing comment — a bare SHA cannot be bumped by Dependabot.
- Each reusable self-gates on changed files, so an untouched surface skips and reports success; that is what lets every check be required without blocking an unrelated pull request.
- A reported name is composed across the reusable boundary as `<caller job key> / <leaf job name>`. The seven required here are named in [`rulesets/main.md`](../../rulesets/main.md).
- Local parity: [`containers/checks/`](../../containers/checks/README.md), driven by [`scripts/checks/local.sh`](../../scripts/checks/local.sh).

| Caller job | Reusable workflow | Reported check name |
| --- | --- | --- |
| `jsonc` | `checks-jsonc.yml` | `jsonc / jsonc` |
| `python` | `checks-python.yml` | `python / ruff` |
| `shell` | `checks-shell.yml` | `shell / shellcheck` |
| `yaml` | `checks-yaml.yml` | `yaml / syntax` · `yaml / actionlint` |
| `secrets` | `security-gitleaks.yml` | `secrets / gitleaks` |
| `deps` | `security-deps.yml` | `deps / dependency-review` — pull requests only |

## `branch-policy.yml`

- **Trigger:** `create:` only. It holds no logic: one job, `policies`, calls the shared `branch-policy.yml` leaf in `mathewmusango/my-workflows`, at the same SHA-pin and tag comment as `checks.yml`. It reports as `policies / branch` and is **not** a required check.
- **It reports, it does not block.** A `create:`-triggered job fires *after* the ref exists, so the name is already made; `main` and `dependabot/*` pass, and anything else takes a typed prefix — `feature/`, `fix/`, `docs/`, `ci/`, `infra/`, `security/`, `governance/`, `deps/`, `content/` (not `chore/`, not `feat/`).

## `codeql.yml`

- Push and pull requests to `main`, weekly, and manual dispatch. Matrix: `actions` + `python`, each `build-mode: none`, on `security-extended` with `fail-fast: false`.
- `security-events: write` + `contents: read` on the job; every action SHA-pinned with a version comment.
- Alerts are gated by the ruleset's `code_scanning` rule (`high_or_higher`, analysis `errors`), not by a required check — so `Analyze (…)` stays out of the required set and adding a language needs no ruleset edit.
