# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repo is public

This dotfiles repo is public. Do not commit secrets, credentials, API keys, or
private hostnames. Secrets are loaded at runtime from `~/.shell/secrets.sh`
(not tracked here).

## Commands

```bash
# Apply dotfiles to home directory
chezmoi apply -v

# Preview pending changes without applying
chezmoi diff

# Edit a managed file (opens in $EDITOR)
chezmoi edit ~/.bashrc

# Run all pre-commit checks
task pre-commit        # or: pipx run pre-commit run --all-files

# Format files
task fmt               # YAML formatting

# Lint files
task lint              # Markdown linting

# Docker testing (Linux devcontainer simulation)
task docker:build
task docker:run
```

## Architecture

All managed files live under `home/` (the chezmoi source directory). Chezmoi applies
`home/` to `~/` using filename conventions:

- `dot_` prefix → `.` in target (e.g., `dot_bashrc` → `~/.bashrc`)
- `dot_config/` → `~/.config/`
- `.tmpl` suffix → processed as a Go template before writing
- `run_once_*` scripts → run once per machine (hash-tracked)
- `run_onchange_*` scripts → re-run when the script's content changes
- `run_once_before_*` → run before applying other files

Templates branch on:

- `{{ .chezmoi.os }}` — `"darwin"` vs `"linux"`
- `{{ .profile }}` — `"personal"`, `"work"`, or `"devcontainer"`
- `{{ .isSynology }}` — Synology NAS detection
- `{{ .disableSSHGitConfig }}` — disables SSH→HTTPS git URL rewriting

## Profiles

Configured in `~/.config/chezmoi/chezmoi.toml` via `data.profile`. Current options:

- `personal` — macOS workstation; full toolchain, notifications, telemetry
- `work` — macOS workstation; excludes personal casks (Claude app, gcloud, Telegram), uses Jaeger alias
- `devcontainer` — Linux dev container; minimal tooling, no host-only daemons

## Key directories

- `home/.chezmoiscripts/` — Lifecycle scripts; `run_once_before_*` installs prerequisites (Xcode,
  Homebrew), `run_once_*` installs packages, `run_onchange_*` re-applies config when script content
  changes
- `home/.chezmoiexternals/` — External git repos (vim-plug, tpm) managed as chezmoi externals with refresh schedules
- `home/.chezmoidata/packages.yaml` — Single source of truth for all package lists (brews, casks, apt, nix, fisher plugins)
- `home/.chezmoitemplates/` — Reusable template partials included with `{{ template "name" . }}`
- `home/dot_claude/` — Claude Code settings, hooks, and status line script
- `home/dot_shell/` — Shell-agnostic config sourced by bash, zsh, and fish

## Pre-commit hooks

The repo enforces: gitleaks (secret scanning), markdownlint, taplo (TOML format/lint),
shfmt (shell formatting), shellcheck (shell linting), yamlfmt. Run `task install` to
set up the pre-commit hooks locally.
