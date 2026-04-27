#!/bin/bash

# Skip on environments where vim is not installed (e.g. devcontainer — use VS Code instead)
command -v vim >/dev/null 2>&1 || exit 0

# Install and update plugins non-interactively
\vim -c PlugInstall -c qa
\vim -c PlugUpdate -c qa
