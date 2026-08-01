#!/bin/bash
# Claude Code status line — inspired by Starship prompt configuration

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
five_hour_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
seven_day_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
five_hour_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
seven_day_reset=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')

GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
DIM='\033[2m'
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
    # Helper: color-code a rounded percentage value
    pct_color() {
        local pct
        pct=$(printf "%.0f" "$1" 2>/dev/null || echo "$1")
        if [ "$pct" -ge 90 ] 2>/dev/null; then
            printf "%b" "${RED}${pct}%${RESET}"
        elif [ "$pct" -ge 70 ] 2>/dev/null; then
            printf "%b" "${YELLOW}${pct}%${RESET}"
        else
            printf "%b" "${GREEN}${pct}%${RESET}"
        fi
    }

    # Helper: dim "(3h12m)" countdown until an epoch timestamp; empty if past/unset
    reset_countdown() {
        local target now remaining days hours mins out
        target="$1"
        [ -n "$target" ] || return 0
        now=$(date +%s)
        remaining=$((target - now))
        [ "$remaining" -gt 0 ] || return 0

        days=$((remaining / 86400))
        hours=$((remaining % 86400 / 3600))
        mins=$((remaining % 3600 / 60))

        if [ "$days" -gt 0 ]; then
            if [ "$hours" -gt 0 ]; then
                out="${days}d${hours}h"
            else
                out="${days}d"
            fi
        elif [ "$hours" -gt 0 ]; then
            out="${hours}h${mins}m"
        else
            out="${mins}m"
        fi

        printf "%b" " ${DIM}(${out})${RESET}"
    }

    usage_segment="ctx $(pct_color "$used_pct")"

    if [ -n "$five_hour_pct" ]; then
        usage_segment="${usage_segment} / 5h $(pct_color "$five_hour_pct")$(reset_countdown "$five_hour_reset")"
    fi

    if [ -n "$seven_day_pct" ]; then
        usage_segment="${usage_segment} / 7d $(pct_color "$seven_day_pct")$(reset_countdown "$seven_day_reset")"
    fi

    line="${line} | ${usage_segment}"
fi

if [ -n "$cost" ]; then
    cost_fmt=$(printf '$%.4f' "$cost")
    line="${line} | ${cost_fmt}"
fi

printf "%b" "$line"
