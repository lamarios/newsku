# CLAUDE.md — Binding Rules for AI-Assisted Development

> **Scope:** This document is the **sole, authoritative rule base** for this repository.
> It supersedes any additional AI / design / README rule files. Chapters that do not
> apply to this repo (e.g. web-specific rules) are **ignored** — no additional files
> are needed.

---

## Wissensquelle: llm-wiki (Todoteck)

Zentrale, gepflegte Wissensschicht für projektübergreifendes Wissen ist das **Projekt `llm-wiki` in Todoteck** — erreichbar über den Todoteck-MCP-Server (`mcp__Todoteck__*`) oder die Todoteck-Weboberfläche.

> Es gibt **kein** Wiki-Repository auf GitHub. Ein früheres Spiegel-Repo ist archiviert und irrelevant — nicht lesen, nicht verlinken, nicht pflegen.

Pflicht vor inhaltlichen Antworten:
1. Notiz **`_index`** lesen — Katalog aller Wiki-Seiten.
2. Mindestens die Repo-Übersicht öffnen: Notiz **`newsku (Feedteck)`**.
3. Bei übergreifenden Themen die jeweilige Konzept- oder Entitäts-Notiz aus dem Katalog.

Nach faktischen Änderungen mit Wissens-Charakter: betroffene Wiki-Notiz pflegen. Spielregeln stehen in der Notiz **`_schema`** — insbesondere „eine Heimat pro Fakt", das Lifecycle-Vokabular und die Log-Rotation.

Ein `_log`-Eintrag nur bei **Entscheidungen und Korrekturen** — nicht bei reinen Inhalts-Aktualisierungen, die zeigt die Versionshistorie der Notiz ohnehin. Im Zweifel weglassen. (Experiment bis 2026-09-21, bewusst noch nicht im `_schema`.)

Werkzeuge: `search` / `get_note` zum Lesen, `append_note` für reine Ergänzungen (kein Markdown-Round-Trip), `update_note` nur für echte Korrekturen im Bestand, danach `sync_wikilinks` und `lint_wiki`.

**Arbeitsteilung:** Architektur-Überblick, Betriebsort (Stack `newsteck` auf MINT) und FreshRSS-Anbindung stehen im Wiki; API, Client und Konfiguration stehen **in diesem Repo**. Nicht duplizieren — verlinken.

---

## Documentation Index

| Document | Contents |
|----------|--------|
| [README.md](README.md) | Feature overview, architecture diagram, API reference |
| [CHANGELOG.md](CHANGELOG.md) | Chronological log of merged changes (date-grouped, no SemVer) |
| [DESIGN.md](DESIGN.md) | Design system — tokens, components, colour, typography, motion |
| [docs/architektur.md](docs/architektur.md) | Tech stack, data models, request flow, auth |
| [docs/verzeichnisstruktur.md](docs/verzeichnisstruktur.md) | Complete file tree with absolute paths |
| [docs/api-patterns.md](docs/api-patterns.md) | Spring controllers, services, repositories, validation |
| [docs/frontend-patterns.md](docs/frontend-patterns.md) | Flutter/BLoC patterns, routing, widgets |
| [docs/datenbank.md](docs/datenbank.md) | JPA/Hibernate schema, Flyway migrations, relationships |
| [docs/entwicklung.md](docs/entwicklung.md) | Setup, dev server, feature walkthrough |
| [docs/code-konventionen.md](docs/code-konventionen.md) | Style guide, naming, Java and Dart patterns |
| [docs/testing.md](docs/testing.md) | JUnit, TestContainers, Flutter tests, mocking |
| [docs/haeufige-aufgaben.md](docs/haeufige-aufgaben.md) | How-to guides for common tasks |
| [docs/design-system.md](docs/design-system.md) | Legacy Flutter/M3 design reference (see DESIGN.md for canonical tokens) |

---

## Table of Contents

1. [Core Principles](#1-core-principles)
1a. [Working Style for Long Sessions (API Stability)](#1a-working-style-for-long-sessions-api-stability)
2. [Permitted / Not Permitted](#2-permitted--not-permitted)
3. [Branching, Merge, Reviews](#3-branching-merge-reviews)
4. [Image Builds (Local Runner)](#4-image-builds-local-runner)
5. [Quality Requirements (Gates)](#5-quality-requirements-gates)
6. [Security & Secrets](#6-security--secrets)
7. [OWASP Top 10](#7-owasp-top-10)
8. [robots.txt](#8-robotstxt)
9. [Database & Migrations](#9-database--migrations)
10. [Logging & Health](#10-logging--health)
10a. [Sync Cadence with External Services](#10a-sync-cadence-with-external-services)
11. [Build & Deployment](#11-build--deployment)
12. [Definition of Done](#12-definition-of-done)
13. [Documentation Requirements](#13-documentation-requirements)
14. [README Structure (Template)](#14-readme-structure-template)
15. [Design System](#15-design-system)

---

## 1. Core Principles

- **GitOps first**: Production is updated exclusively via versioned images and declarative infrastructure rollouts.
- **No runtime hotfixes**: Bug fixes go through code change → new image → deployment.
- **Reproducibility**: A **Git tag (if used)** must always produce the same build (CI/CD is the source of truth).

---

## 1a. Working Style for Long Sessions (API Stability)

> Goal: Avoid stream timeouts (`Stream idle timeout — partial response received`). The cause is **single long operations without intermediate output**, not the number of parallel tool calls.

### Keep Output Small

- **Filter** Bash output: `head -n 100`, `tail -n 100`, `grep -E '...'`, `wc -l` instead of full logs/dumps.
- Read large files **in segments** (`Read` with `offset`/`limit`), not all at once.
- No `find . | ...` dumps of entire project trees — use targeted `find`/`rg` queries with path filters.

### Do Not Block on Long Runs

- Start builds, tests, installs, Gradle/Maven runs, and Flutter builds as **background tasks** (`run_in_background: true`), not in the foreground.
- Set realistic **timeouts** on Bash calls; hanging processes should abort quickly rather than silently blocking the stream.
- No `sleep` loops or poll-busy-waits in the main thread.

### Protect Context

- For **broad codebase research** (>3 queries, unclear scope) use the `Explore` subagent — it encapsulates large search results and returns only a summary.
- For **design decisions** use the `Plan` subagent before making extensive edits.

### Efficient Over Cautious

- Run **independent** tool calls in a single message **in parallel** (e.g. multiple `Read`s or `grep`s) — this reduces total time and therefore timeout risk.
- Sequential only when one call depends on the result of the previous.

### Structure Large Tasks

- Tasks with many file changes (>10 files or >3 logically separate sub-steps) are broken into **traceable steps**, each a self-contained unit with an intermediate result.
- Use `TodoWrite` to keep progress visible and resume seamlessly after interruptions.

---

## 2. Permitted / Not Permitted

### The AI May

- Change and refactor code (within the existing architecture)
- Create/modify files (including tests and documentation)
- Adjust build/CI configuration (if necessary and justified)
- Adapt CI/CD workflows for Local Runner (self-hosted runner)

### The AI Must NOT

- Suggest `docker compose up` as **production operation**
- Manipulate containers directly (exec, hotpatch, manual changes)
- Make changes directly in Portainer
- Recommend manual `docker build` or `docker push` **for production**
- Make infrastructure assumptions (host paths, volumes, networks) unless explicitly provided

> Note: `docker compose` can be useful for **local development**, but is **not** the production operation/deploy path.

---

## 3. Branching, Merge, Reviews

- Development on feature/fix branches
- Merge via Pull Request
- `main` is release-ready / production-near and protected
- CI must be green before merging

Recommended branch naming: `feature/...`, `fix/...`, `chore/...`

PR includes: purpose, scope, test notes, possible breaking changes

---

## 4. Image Builds (Local Runner)

Custom images are built via GitHub Actions with a self-hosted runner.

- **No GitHub Releases / no SemVer / no Git tags** as "release mechanism" for custom images
- Build trigger: push to `main` (after PR merge) or manually via `workflow_dispatch`
- Images receive **container tags** `latest` + short SHA commit hash
- Registry: GHCR (`ghcr.io/<owner>/<image>`)
- Every merge to `main` automatically produces a new image

---

## 5. Quality Requirements (Gates)

Before a merge to `main`:

- Tests run (unit/integration if available)
- Linting/formatting is consistent
- No debug output / temporary workarounds
- No unused ENV variables
- Build in CI successful and reproducible

Recommended CI jobs: `lint`, `test`, `build`, optional `security` (dependency/secret scan)

---

## 6. Security & Secrets

- No secrets in code or repo
- No tokens/keys in logs
- Never commit `.env` — use `.env.example` instead
- Secrets exclusively via ENV/secret management
- No "default admin password" in production images

---

## 7. OWASP Top 10

During development the OWASP Top 10 **must** be considered:
https://owasp.org/Top10/2025/

**Rule:** If this repo provides web/API endpoints, OWASP applies as a minimum checklist. If not (e.g. CLI/lib), OWASP applies by analogy (input validation, supply chain, secrets, logging).

---

## 8. robots.txt

> Applies only to publicly accessible web applications. Ignore for libraries/CLIs.

Every publicly accessible web application **must** provide a `robots.txt`:

- Served at root (`/robots.txt`)
- Sensitive paths (admin, API, internal tools) excluded via `Disallow`
- Versioned in the repository — no manual production changes
- AI crawlers (`GPTBot`, `CCBot`, `anthropic-ai`) explicitly blocked

Example (restrictive):

```text
User-agent: *
Disallow: /admin
Disallow: /api/
Disallow: /internal/

User-agent: GPTBot
Disallow: /

User-agent: CCBot
Disallow: /

Sitemap: https://example.com/sitemap.xml
```

> `robots.txt` is **not a security mechanism** — sensitive endpoints must additionally be protected by auth and access control.

---

## 9. Database & Migrations

> Applies only if the repo uses a DB.

- Schema changes exclusively via migrations
- Migrations are versioned, reproducible, and ideally rollbackable
- No manual DB hotfixes in production

---

## 10. Logging & Health

> Healthcheck applies only to services.

- Logs structured or unambiguously parseable
- Log level consistent (`ERROR/WARN/INFO/DEBUG`), production default `INFO`
- Healthcheck endpoint present (`/health` or `/healthz`)
- Healthcheck is fast and without heavy queries

---

## 10a. Sync Cadence with External Services

> Applies when this repo polls data from an external service (e.g. FreshRSS via GReader API).

- **Align poll interval with the source:** Sync interval must not be shorter than the update cadence of the upstream service. Shorter intervals only generate idle load + unnecessary API load.
- **Time offset:** When the upstream service works at fixed times (e.g. FreshRSS cron), set your own sync via cron expression to run a few minutes after the upstream fetch.
- **Configuration via ENV:** Sync schedules are configurable via ENV variable (not hardcoded) so adjustments are possible without rebuild.
- **Documentation requirement:** Every sync cadence is documented in `README.md` (ENV table) with justification — including a note on the upstream cadence it is aligned with.
- **Currently relevant:** FreshRSS `CRON_MIN=10,30,50` (3×/hour) → newsku default `FEED_SYNC_CRON=0 15,35,55 * * * *` (sync 5 min after each FreshRSS fetch).

---

## 11. Build & Deployment

### Custom Images (Local Runner)

- PR → merge to `main` → GitHub Actions builds image on self-hosted runner
- Push to GHCR (container tags: `latest` + SHA)
- Manual trigger via `workflow_dispatch` possible

### Deployment in docker-configs (GitOps)

- Deployment via docker-configs via Portainer GitOps (polling)
- Renovate creates PRs for third-party image updates → merge → Portainer redeploy
- No manual manipulation of deployments

### Rollback

- Rollback by reverting to previous GHCR image (SHA tag) in docker-configs repo
- Then redeploy and post-check

---

## 12. Definition of Done

A change is "done" when:

- Code implemented
- Tests green
- Documentation updated (at minimum README, if affected)
- `CHANGELOG.md` updated (entry under `[Unreleased]` or under a date block — see §13)
- PR reviewed and merged
- **If image-based:** CI image built & available (GHCR), deployment triggered/completed
- **If release-based (libraries):** Release/tag built (only if the repo works this way)
- Post-check successful (health/login/version visible, if relevant)

---

## 13. Documentation Requirements

For every change that can go to production:

- Check/update README
- Changes described in a traceable manner in the PR
- **`CHANGELOG.md` updated** (see rules below)

### CHANGELOG.md (mandatory)

- **Every PR that lands on `main` MUST update `CHANGELOG.md`.**
- Add the entry under `## [Unreleased]` while the PR is open. On merge, either
  the PR itself or a follow-up housekeeping PR moves the `[Unreleased]` items
  into a dated block `## [YYYY-MM-DD]` (the merge date on `main`).
- Format follows [Keep a Changelog 1.1.0](https://keepachangelog.com/en/1.1.0/)
  with the categories **Added / Changed / Fixed / Security / Removed /
  Deprecated / Docs / Chore**.
- Each entry: short imperative description plus PR number in parentheses, e.g.
  `- Guard against empty feeds list in getPublicItems (#103)`.
- Pure refactors / whitespace-only / merge commits may be omitted.
- **No SemVer / no Git tags** — sections are date-grouped (see §4, §11).

---

## 14. README Structure (Template)

Every `README.md` in this repository follows this structure. Sections that do not apply are omitted — the order remains the same.

### Principles for READMEs

- **English** — all READMEs in English
- **Self-explanatory** — setup & operation must be possible without additional documentation
- **No filler** — every section has a clear purpose
- **Tables > prose**
- **ASCII diagrams > no diagrams** — no external images

### Mandatory Structure

| # | Section | Required | Condition for Optional |
|---|---------|---------|------------------------|
| 1 | Header with badges | **Yes** | — |
| 2 | User interface | No | Only for apps with UI |
| 3 | Feature overview | **Yes** | — |
| 4 | Architecture | **Yes** | — |
| 5 | Prerequisites | **Yes** | — |
| 6 | Installation / Quick start | **Yes** | — |
| 7 | Reverse proxy setup | No | Only for special proxy config |
| 8 | Configuration | **Yes** | — |
| 9 | API reference | No | Required for own APIs |
| 10 | Database schema | No | Recommended for own DBs |
| 11 | Security aspects | **Yes** | — |
| 12 | Technology stack | **Yes** | — |
| 13 | Project structure | No | Recommended for monorepos |
| 14 | Development | **Yes** | — |
| 15 | Versioning | No | Recommended |
| 16 | License | **Yes** | — |

---

## 15. Design System

→ Canonical token reference: [DESIGN.md](DESIGN.md)

→ Flutter/M3 patterns: [docs/design-system.md](docs/design-system.md)


## Compatibility with Other AI Tools

This file is named `CLAUDE.md` and is automatically recognised by Claude Code.

For other tools:

| Tool | Expected Path |
|---|---|
| Claude Code | `CLAUDE.md` (repository root) ✅ |
| GitHub Copilot | `.github/copilot-instructions.md` |
| Cursor | `.cursor/rules` or `.cursorrules` |
| Windsurf | `.windsurfrules` |
| Cline | `.clinerules` |

Recommendation: Create symlinks or copies of `CLAUDE.md` at the respective paths
so all tools use the same rules.
