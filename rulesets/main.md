# Ruleset: `main` — record

**Status:** 🟢 applied — live on `refs/heads/main` · **Config:** [`main.json`](main.json)

**Purpose.** `main` binds every actor: pull requests only, one approval, squash only, seven shared-check contexts, no bypass.

| Field | Value |
| --- | --- |
| Enforcement | `active` |
| Merge methods | `squash` only |
| Approvals | 1 · stale reviews dismissed on push · review threads resolved · an extra approval for unattributed changes |
| Required checks | the seven contexts below, strict |
| Bypass actors | none |
| Also | `creation` · `deletion` · `non_fast_forward` · `required_signatures` · `code_scanning` (`high_or_higher`, analysis `errors`) |

## The required contexts

| Context | Comes from |
| --- | --- |
| `jsonc / jsonc` | the `jsonc` caller job |
| `python / ruff` | the `python` caller job |
| `shell / shellcheck` | the `shell` caller job |
| `yaml / syntax` | the `yaml` caller job |
| `yaml / actionlint` | the `yaml` caller job |
| `secrets / gitleaks` | the `secrets` caller job |
| `deps / dependency-review` | the `deps` caller job — reports on pull requests only |

## Applying

```sh
# Read it back — this is how the file here was produced
gh api repos/mathewmusango/dotfiles/rulesets

# Replace it in place. Strip id, source and source_type from the body first:
# they are read-only, and the id lives in the URL.
gh api --method PUT repos/mathewmusango/dotfiles/rulesets/23519428 --input rulesets/main.json
```

**Verified.** Read back with `gh api repos/mathewmusango/dotfiles/rulesets` on 2026-09-23, and again on 2026-09-25: two rulesets now — this one, and [`branches: all`](all.md) for the branch-name gate — with no bypass actors. A context joins the required set only after a run has reported it, so the set holds what has actually run. **Corrected 2026-09-25:** live had drifted to **eight** contexts, carrying a `policies / branch` that this record never listed — a `create:`-only context, which can never be satisfied on a branch that is pushed to again, and with no bypass it would have hung the second push to any open pull request. The `PUT` below removed it, so live now matches this record.

**Change flow.** Edit the JSON (export format) → apply it → update this record in the same pull request.
