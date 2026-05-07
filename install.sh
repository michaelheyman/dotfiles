#!/bin/sh

# -e: exit on error
# -u: exit on unset variables
set -eu

bin_dir="${HOME}/.local/bin"
chezmoi="${bin_dir}/chezmoi"
if ! command -v chezmoi >/dev/null 2>&1 && [ ! -x "${chezmoi}" ]; then
	echo "Installing chezmoi to '${chezmoi}'" >&2
	mkdir -p "${bin_dir}"
	curl -fsSL "https://github.com/twpayne/chezmoi/releases/latest/download/chezmoi-linux-amd64" \
		-o "${chezmoi}"
	chmod +x "${chezmoi}"
elif command -v chezmoi >/dev/null 2>&1; then
	chezmoi="$(command -v chezmoi)"
fi
unset bin_dir

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

set -- init --apply --source="${script_dir}"

echo "Running 'chezmoi $*'" >&2
# exec: replace current process with chezmoi
exec "$chezmoi" "$@"
