#!/bin/bash

# Trigger vim plugin installation when the ~/.vim directory has changed
# Modified Date: {{ with stat (joinPath .chezmoi.homeDir ".vim") }}{{ .modTime }}{{ else }}never{{ end }}

# Skip on environments where vim is not installed (e.g. devcontainer — use VS Code instead)
command -v vim >/dev/null 2>&1 || exit 0

\vim -c PlugInstall -c qa
\vim -c PlugUpdate -c qa
