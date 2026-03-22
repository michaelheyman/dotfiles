#!/bin/bash
# Claude Code status line — inspired by Starship prompt configuration

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')

GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
RESET='\033[0m'

# Fish-style path shortening: shorten each parent component to 1 char
fish_path() {
	dir="$1"
	home="$HOME"
	# Replace home prefix with ~
	case "$dir" in
	"$home"*) dir="~${dir#"$home"}" ;;
	esac
	# Split by / and shorten all but the last component to 1 character
	IFS='/' read -ra parts <<-EOF
		$dir
	EOF
	result=""
	total=${#parts[@]}
	for i in "${!parts[@]}"; do
		part="${parts[$i]}"
		if [ -z "$part" ]; then
			result="/"
			continue
		fi
		if [ "$i" -eq $((total - 1)) ]; then
			result="${result}/${part}"
		else
			result="${result}/${part:0:1}"
		fi
	done
	echo "${result/#\/\//\/}"
}

# Git branch (skip optional locks)
git_branch=""
if git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
	git_branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null ||
		git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
fi

short_path=$(fish_path "$cwd")

# Build status line
line="${short_path}"

if [ -n "$git_branch" ]; then
	line="${line} ${git_branch}"
fi

if [ -n "$model" ]; then
	line="${line} | ${model}"
fi

if [ -n "$used_pct" ]; then
	printf_pct=$(printf "%.0f" "$used_pct" 2>/dev/null || echo "$used_pct")
	if [ "$printf_pct" -ge 90 ] 2>/dev/null; then
		ctx_color="$RED"
	elif [ "$printf_pct" -ge 70 ] 2>/dev/null; then
		ctx_color="$YELLOW"
	else
		ctx_color="$GREEN"
	fi
	line="${line} | ${ctx_color}ctx ${printf_pct}%${RESET}"
fi

if [ -n "$cost" ]; then
	cost_fmt=$(printf '$%.4f' "$cost")
	line="${line} | ${cost_fmt}"
fi

printf "%b" "$line"
