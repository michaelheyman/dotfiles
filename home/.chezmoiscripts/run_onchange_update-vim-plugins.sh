#!/bin/bash

# Trigger vim plugin installation when the ~/.vim directory has changed
# Modified Date: {{ (stat (joinPath .chezmoi.homeDir ".vim")).modTime }}

# Install and update plugins non-interactively
\vim -c PlugInstall -c qa
\vim -c PlugUpdate -c qa
