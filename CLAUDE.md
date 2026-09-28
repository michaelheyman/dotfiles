# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repo is public

This dotfiles repo is public. Do not commit secrets, credentials, API keys, or
private hostnames. Secrets are loaded at runtime from `~/.shell/secrets.sh`
(not tracked here).

## Commands

```bash
chezmoi apply -v       # apply dotfiles to the home directory
chezmoi diff           # preview pending changes
task pre-commit        # run all pre-commit checks
task --list            # every other task (format, lint, Docker testing, ...)
```

## Architecture

All managed files live under `home/` (the chezmoi source directory), applied to `~/` using
chezmoi's source-state naming: `dot_`, `.tmpl`, and the `run_once_`/`run_onchange_`/`before_`
script prefixes.

Templates branch on `.chezmoi.os` and on variables in the `[data]` section of the chezmoi
config templates (`home/.chezmoi.toml.tmpl` and `home/dot_config/chezmoi/chezmoi.toml.tmpl`).
The most important is `.profile`, which separates full workstation setups from a minimal
dev container. The profile prompt in `home/.chezmoi.toml.tmpl` lists the valid values.

## Key directories

- `home/.chezmoiscripts/` — lifecycle scripts that install prerequisites and packages, and
  re-apply config when a script's content changes
- `home/.chezmoiexternals/` — external git repos managed as chezmoi externals
- `home/.chezmoidata/packages.yaml` — single source of truth for package lists
- `home/.chezmoitemplates/` — reusable template partials, included with `{{ template "name" . }}`
- `home/dot_claude/` — Claude Code config
- `home/dot_shell/` — shell-agnostic config sourced by every shell

## Pre-commit hooks

`.pre-commit-config.yaml` defines the hooks, including secret scanning with gitleaks. Run
`task install` to set them up locally.
