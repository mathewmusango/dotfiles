# Ruleset: `branches: all` — record

**Status:** 🟢 applied — live on every branch · **Config:** [`all.json`](all.json)

**Purpose.** The branch-name gate. There is no allow-list rule for names to use here: `branch_name_pattern` is rejected by the API (`422 Invalid rule`, with an empty reason) and the UI does not offer "Restrict branch names" either. So the allow-list is expressed the other way round — this ruleset targets **every** branch, *excludes* the names that are allowed, and applies `creation`. Creating anything not excluded is refused at the push.

| Field | Value |
| --- | --- |
| Target | every branch (`~ALL`), minus the excludes below |
| Required checks | none — this gates creation, not merging |
| Bypass actors | none, so the name rules bind everyone, owner included |
| Rules | `creation` only |

**Why exactly one rule.** An all-branches ruleset that also carried `deletion`, `non_fast_forward` or `pull_request` would protect every branch the way `main` is protected — and its `deletion` rule would make a badly named branch **impossible to delete**. Deletion and force-push protection belong to `branch: main`.

## The allowed names

The excludes *are* the allow-list:

| Excluded, i.e. allowed | Notes |
| --- | --- |
| `refs/heads/main` | the default branch |
| `refs/heads/dependabot/*` · `/*/*` · `/*/*/*` · `/*/*/*/*` | four levels, so a monorepo branch such as `dependabot/npm_and_yarn/packages/app/foo-1.0.0` is not refused |
| `refs/heads/feature/*` · `fix/*` · `docs/*` · `ci/*` · `infra/*` · `security/*` · `governance/*` · `deps/*` · `content/*` | one path segment each |

`chore/` and `feat/` are deliberately absent — `chore` names an issue bucket rather than a branch type, and `feature/` is the standard spelling. Branches such as the earlier `chore/ruleset-readout` are now refused, so work that would have taken that prefix takes `ci/` or `docs/` instead.

## Applying

```sh
# Read it back — this is how the file here was produced
gh api repos/mathewmusango/dotfiles/rulesets/24010668

# Replace it in place. Strip id, source and source_type from the body first:
# they are read-only, and the id lives in the URL.
gh api --method PUT repos/mathewmusango/dotfiles/rulesets/24010668 --input rulesets/all.json
```

**Verified.** Read back and probed in the same pass on 2026-09-25: `bad/probe-dotfiles` was **refused** — `GH013: Cannot create ref due to creations being restricted` — while `ci/probe-verify` and a four-deep `dependabot/…` branch were **accepted**, then deleted.

**Change flow.** Edit the JSON (export format) → apply it → update this record in the same pull request.
