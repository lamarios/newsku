# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Newsku is a self-hosted RSS reader that uses an LLM (any OpenAI-compatible API) to rank feed items by importance based on user preferences. The repo contains two apps:

- **Backend**: Spring Boot 4 / Java 25 / PostgreSQL, Maven project at repo root (`src/main/java`, `src/main/resources`, `src/test`).
- **Frontend**: Flutter app in `src/main/app`, built for web (served by the backend) and Android.

## Dev environment

`nix-shell` (see `shell.nix`) provides JDK 25, Maven, and mkdocs. It also inits the Flutter git submodule (`src/main/app/submodules/flutter`, put on `PATH`) and installs a pre-commit hook (`tools/setup_git_hooks.dart`). The hook runs `dart format` + `dart analyze` on `src/main/app/lib` and `mvn spotless:apply` (google-java-format), then re-stages the files. Use the submodule's `flutter`/`dart`, not a system install.

## Backend commands

```bash
mvn clean install                         # build + tests (CI runs this)
mvn test                                  # tests only
mvn test -Dtest=FeedControllerTest        # single test class
mvn test -Dtest=FeedControllerTest#method # single test method
mvn spotless:apply                        # format Java (google-java-format)
```

Tests need Docker: `TestContainerTest` starts a `postgres:18` Testcontainer.

Running locally needs Postgres (defaults are `localhost:15432`, user/pass `postgres`, overridable with `DB_HOST`/`DB_PORT`/`DB_DATABASE`/`DB_USER`/`DB_PASSWORD`) plus the required env vars `SALT`, `OPENAI_URL` and `OPENAI_MODEL`. The full list of env vars is in `mkdocs/docs/2-configuration.md`.

## Frontend commands (run in `src/main/app`)

```bash
make build-runner           # regenerate freezed / json_serializable / auto_route code
make build-runner-watch
flutter test                          # all tests (CI runs this)
flutter test test/feed/feed_test.dart # single file
make generate-goldens                 # flutter test --update-goldens
make web-build                        # flutter build web --release --wasm
```

Generated files (`*.freezed.dart`, `*.g.dart`, `router.gr.dart`, `l10n/app_localizations*.dart`) are committed. Regenerate them after you change models, states or routes. Localized strings live in `lib/l10n/app_en.arb`. The analyzer enforces `always_use_package_imports` (`package:app/...`) and a 120-char page width.

## Docs

`make docs-build` / `make docs-serve` at the root builds the mkdocs site in `mkdocs/` into `docs/documentation` (GitHub Pages).

## Architecture

### Backend (`com.github.lamarios.newsku`)

- Layering: `controllers` (REST under `/api/**`) → `services` → `persistence/repositories` (Spring Data JPA) → `persistence/entities`. `models` holds DTOs and enums.
- Schema is managed by Flyway (`src/main/resources/db/migration/V<n>__Name.sql`). Add a new versioned migration; never edit existing ones.
- **Auth** (`security/`): stateless. `JwtRequestFilter` reads the `Authorization` header. A `Bearer` value is validated as a JWT. Any other value is treated as an API key and resolved via `ApiKeyService`. Everything under `/api/**` requires auth; everything else is permitted. OIDC is supported via `OidcService`. `SALT` signs JWTs and hashes API keys, so it must never change on an existing install.
- **Per-user scoping**: services get the caller from `UserService.getCurrentUser()` and scope queries to that user.
- **Feed pipeline**: `ScheduleService` refreshes all feeds hourly. `FeedItemService.refreshFeed` queues the work onto `BackgroundTasks`, a single-thread executor. The worker parses the RSS, then for each new item calls `OpenaiService.processFeedItem` (which uses the user's preferences and click history) to get an importance score and tags. Clicks are recorded by `ClickService` and feed back into the LLM context.
- `DEMO_MODE` makes most mutating controllers reject writes. `ALLOW_SIGNUP` gates `SignUpController`.
- Email (password reset, digests) goes through `EmailService` with Freemarker templates in `src/main/resources/templates/email`.
- Static web UI: CI builds the Flutter web app and copies `build/web` into `src/main/resources/public`, which Spring serves at `/`.

### Backend tests

Integration tests extend `TestContainerTest` (full `@SpringBootTest` on a random port). `TestConfig` swaps in `MockOpenaiService`, `MockEmailService`, `TestUserService` (set the current user directly) and `FakeRssFeedController` (serves RSS fixtures). Each test signs up a `test` user beforehand. Afterwards it waits on `BackgroundTaskUtils.waitForTasksToFinish()` and then wipes the DB, because adding feeds spawns background refreshes.

### Frontend (`src/main/app/lib`)

- Organized by feature (`feed`, `settings`, `layouts`, `user`, `identity`, `stats`, …), each with `models/`, `services/`, `states/` and `views/{screens,components,tabs}`.
- State is managed with `flutter_bloc` Cubits whose state classes are `freezed`. Global singletons (`IdentityCubit`, `LocalPreferencesCubit`) are registered in `get_it` (`getIt` in `main.dart`).
- HTTP services extend `BaseService`, which builds URLs against the user-configured server URL, adds the JWT from `SharedPreferences`, and maps errors and 401s to logout.
- Routing uses `auto_route` (`router.dart` → generated `router.gr.dart`).
- Feed layout is user-configurable from "layout blocks" (`LayoutBlockType` on the backend, `layouts/` on the frontend), e.g. headline, top stories, grids.
- Android-only notifications and background refresh go through `notifications/` using conditional imports (`notification_handler_io.dart` / `_stub.dart`).

### Frontend tests

Widget tests call `setupTests()` from `test/test_utils.dart`, mock HTTP with `nock` using JSON fixtures in `test/fixtures`, and use golden images (`test/**/goldens`, with failures written to `failures/`).

## CI

`.github/workflows/build-java.yml` builds the web app, then runs `mvn clean install`, then pushes a multi-arch Docker image (`docker/Dockerfile`). `build-android.yml` runs `flutter test` and builds the APK/AAB. Tags set the version for releases.
