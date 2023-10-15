# Add the custom bin scripts to the PATH (only if they aren't in the path yet)
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi
