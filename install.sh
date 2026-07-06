#!/bin/sh

# -e: exit on error
# -u: exit on unset variables
set -eu

bin_dir="${HOME}/.local/bin"
chezmoi="${bin_dir}/chezmoi"
if ! command -v chezmoi >/dev/null 2>&1 && [ ! -x "${chezmoi}" ]; then
	os="$(uname -s | tr '[:upper:]' '[:lower:]')"
	case "$(uname -m)" in
	x86_64 | amd64) arch="amd64" ;;
	aarch64 | arm64) arch="arm64" ;;
	*)
		echo "Unsupported architecture: $(uname -m)" >&2
		exit 1
		;;
	esac

	echo "Installing chezmoi to '${chezmoi}'" >&2
	mkdir -p "${bin_dir}"
	curl -fsSL "https://github.com/twpayne/chezmoi/releases/latest/download/chezmoi-${os}-${arch}" \
		-o "${chezmoi}"
	chmod +x "${chezmoi}"
	unset os arch
elif command -v chezmoi >/dev/null 2>&1; then
	chezmoi="$(command -v chezmoi)"
fi
unset bin_dir

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

# /dev/tty always exists as a device node, but opening it fails with ENXIO
# when there's no controlling terminal (e.g. devcontainer CLI lifecycle
# commands), so chezmoi's config template can't detect this on its own.
if ! (: </dev/tty) 2>/dev/null; then
	export CHEZMOI_NO_TTY=1
fi

set -- init --apply --source="${script_dir}"

echo "Running 'chezmoi $*'" >&2
# exec: replace current process with chezmoi
exec "$chezmoi" "$@"
