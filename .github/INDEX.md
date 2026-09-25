# .github

| File | What it is |
| --- | --- |
| [`CODEOWNERS`](CODEOWNERS) | `* @mathewmusango` — one line, no exceptions |
| [`dependabot.yml`](dependabot.yml) | the `github-actions` default, and nothing else — no package manifest here means no ecosystem entry. The pins carry a trailing `# v<tag>`, which is the only thing Dependabot can version-map: an action pinned to a bare SHA cannot be bumped |
| [`workflows/checks.yml`](workflows/checks.yml) | shared checks, one caller job per surface |
| [`workflows/security.yml`](workflows/security.yml) | the secret scanners — `secrets`, `gitguardian`, `deps` — split from `checks.yml` |
| [`workflows/codeql.yml`](workflows/codeql.yml) | CodeQL for `actions` and `python` |
| [`workflows/branch-policy.yml`](workflows/branch-policy.yml) | the branch-name policy, reported from a `create:` trigger as `policies / branch` |

The workflows are documented beside them: [`workflows/`](workflows/README.md).

## Security surfaces

| Surface | Where it acts | Blocks a merge? |
| --- | --- | --- |
| Push protection | `git push`, before the pull request exists | **Yes** — the push is refused |
| Native secret scanning | the whole repository, every branch | No — an alert in the Security tab |
| `secrets / gitleaks` | CI, on the pull request — a required context | **Yes** |
| `gitguardian / gitguardian` | CI, on the pull request — its own caller job and the `GITGUARDIAN_API_KEY` secret | No — it reports; it is not a required context |
| `terraform / security` | CI, on the pull request — Checkov, in `security.yml` | No — `soft_fail: true` while the audit backlog lands |
| `deps / dependency-review` | CI, on the pull-request diff — a required context | **Yes** |
| `Analyze (…)` + the `code_scanning` rule | the pull request's analysis, and the `main`/weekly baseline | **Yes** — on alerts at `high_or_higher` |
| Dependabot alerts | the dependency graph, from the default branch | No — it answers with a patch pull request |

## Settings that are not files

Set by hand; a clone or a pull carries none of them.

| Setting | State |
| --- | --- |
| Rulesets | **applied** — `branch: main`, live; recorded in [`../rulesets/`](../rulesets/README.md) |
| Labels | `dependencies` · `github-actions` · `ci` — the two `dependabot.yml` names exist |
| Push protection | on |
| Secret scanning | on |
| Private vulnerability reporting | on — hence the **Security → Report a vulnerability** route in [`SECURITY.md`](../SECURITY.md) |
| Non-provider secret patterns | **off** — free here, and the only cover for a secret no provider pattern matches |
| Secret validity checks | **off** — free here, and it separates a live secret from a dead one |
