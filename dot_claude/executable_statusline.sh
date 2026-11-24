#!/bin/sh
input=$(cat)

j() { printf '%s' "$input" | jq -r "$1 // empty"; }

DIM="\033[2m"
MUTED="\033[38;2;140;140;150m"
TEXT="\033[38;2;220;220;225m"
WARN="\033[38;2;230;170;80m"
HOT="\033[38;2;235;100;95m"
RESET="\033[0m"
SEP="${DIM}${MUTED}  ·  ${RESET}"

model=$(j '.model.display_name')
effort=$(j '.effort.level')
dir=$(j '.workspace.current_dir // .cwd')

branch=""
dirty=""
if git -C "$dir" rev-parse --git-dir >/dev/null 2>&1; then
  branch=$(git -C "$dir" symbolic-ref --short HEAD 2>/dev/null || git -C "$dir" rev-parse --short HEAD 2>/dev/null)
  [ -n "$(git -C "$dir" status --porcelain --untracked-files=no 2>/dev/null | head -1)" ] && dirty="*"
fi

# Color only speaks when a limit is close; below 70% everything stays grey.
tone() {
  if [ "$1" -ge 90 ]; then printf '%b' "$HOT"
  elif [ "$1" -ge 70 ]; then printf '%b' "$WARN"
  else printf '%b' "$MUTED"; fi
}

# resets_at arrives as epoch seconds.
until_reset() {
  diff=$(( $1 - $(date +%s) ))
  [ "$diff" -le 0 ] && return
  d=$(( diff / 86400 )); h=$(( diff % 86400 / 3600 )); m=$(( diff % 3600 / 60 ))
  if [ "$d" -gt 0 ]; then echo "${d}d${h}h"
  elif [ "$h" -gt 0 ]; then echo "${h}h${m}m"
  else echo "${m}m"; fi
}

meter() {
  label=$1; pct=$2; reset=$3
  [ -z "$pct" ] && return
  p=$(printf '%.0f' "$pct")
  printf '%b%s %s%%%b' "$(tone "$p")" "$label" "$p" "$RESET"
  if [ -n "$reset" ]; then
    left=$(until_reset "$(printf '%.0f' "$reset")")
    [ -n "$left" ] && printf ' %b%b%s%b' "$DIM" "$MUTED" "$left" "$RESET"
  fi
}

printf '%b%s%b' "$TEXT" "$(basename "$dir")" "$RESET"
[ -n "$branch" ] && printf ' %b%s%s%b' "$MUTED" "$branch" "$dirty" "$RESET"
printf '%b%b%s%b' "$SEP" "$MUTED" "$model" "$RESET"
[ -n "$effort" ] && printf ' %b%b%s%b' "$DIM" "$MUTED" "$effort" "$RESET"

five=$(meter 5h "$(j '.rate_limits.five_hour.used_percentage')" "$(j '.rate_limits.five_hour.resets_at')")
week=$(meter 7d "$(j '.rate_limits.seven_day.used_percentage')" "$(j '.rate_limits.seven_day.resets_at')")
ctx=$(meter ctx "$(j '.context_window.used_percentage')" "")

for part in "$five" "$week" "$ctx"; do
  if [ -n "$part" ]; then printf '%b%b' "$SEP" "$part"; fi
done
