#!/usr/bin/env bash
# Claude Code status line command
# Receives JSON on stdin

input=$(cat)

# ANSI color codes
RESET='\033[0m'
# Segment colors
C_MODEL='\033[38;5;75m'    # Steel blue — model name
C_GIT='\033[38;5;114m'     # Soft green — git root:branch
C_SYNC='\033[38;5;221m'    # Amber — ahead/behind
C_DIFF='\033[38;5;221m'    # Yellow — lines added/removed
C_SEP='\033[38;5;240m'     # Dark grey — separator

# Return a gradient ANSI 256-color escape for a usage percentage (0-100).
# Maps: 0% -> green (~46), 50% -> yellow (~226), 100% -> red (~196)
# Uses the 6x6x6 color cube (indices 16-231): index = 16 + 36*r + 6*g + b
# where each channel is 0-5.
rate_color() {
  local pct="$1"
  local int_pct
  int_pct=$(printf '%.0f' "$pct")
  [ "$int_pct" -lt 0 ]   && int_pct=0
  [ "$int_pct" -gt 100 ] && int_pct=100

  local r g b color_idx
  if [ "$int_pct" -le 50 ]; then
    # Green (0,5,0) → Yellow (5,5,0)
    # r goes 0→5 as pct goes 0→50
    r=$(( int_pct * 5 / 50 ))
    g=5
    b=0
  else
    # Yellow (5,5,0) → Red (5,0,0)
    # g goes 5→0 as pct goes 50→100
    r=5
    g=$(( (100 - int_pct) * 5 / 50 ))
    b=0
  fi

  color_idx=$(( 16 + 36 * r + 6 * g + b ))
  printf '\033[38;5;%dm' "$color_idx"
}

# Return an ANSI 256-color escape for a session cost, given the amount in whole
# cents. Discrete thresholds (not a gradient — dollars have no upper bound):
#   < $1 green · < $3 yellow · < $5 orange · ≥ $5 red
cost_color() {
  local cents="$1"
  if   [ "$cents" -ge 500 ]; then printf '\033[38;5;196m'   # red
  elif [ "$cents" -ge 300 ]; then printf '\033[38;5;208m'   # orange
  elif [ "$cents" -ge 100 ]; then printf '\033[38;5;226m'   # yellow
  else                            printf '\033[38;5;46m'    # green
  fi
}

# Strip ANSI escape sequences to measure visible length
visible_len() {
  printf '%s' "$1" | sed 's/\x1b\[[0-9;]*m//g' | wc -m
}

# Detect terminal width.
# 1. $COLUMNS (only works if the parent exported it)
# 2. stty size </dev/tty  — reads actual terminal geometry even when stdin is a
#    pipe (Claude Code's statusline context); extracts the column field
# 3. tput cols </dev/tty  — alternative tty-based query
# 4. Hard fallback: 80
term_width="${COLUMNS:-}"
if [ -z "$term_width" ] || [ "$term_width" -le 0 ] 2>/dev/null; then
  term_width=$(stty size </dev/tty 2>/dev/null | awk '{print $2}')
fi
if [ -z "$term_width" ] || [ "$term_width" -le 0 ] 2>/dev/null; then
  term_width=$(tput cols </dev/tty 2>/dev/null)
fi
if [ -z "$term_width" ] || [ "$term_width" -le 0 ] 2>/dev/null; then
  term_width=80
fi

# Subtract a safety margin for Claude Code's TUI frame padding/borders.
# The frame reserves columns on the right edge that the status line cannot use.
term_width=$(( term_width - 4 ))

# Model
model=$(echo "$input" | jq -r '.model.display_name // "unknown"')

# Git info (run in cwd from JSON)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')

git_branch=""
git_root_name=""
git_subpath=""
git_ahead=""
git_behind=""

if [ -n "$cwd" ] && cd "$cwd" 2>/dev/null; then
  if git rev-parse --git-dir > /dev/null 2>&1; then
    git_branch=$(git -c gc.auto=0 symbolic-ref --short HEAD 2>/dev/null || git -c gc.auto=0 rev-parse --short HEAD 2>/dev/null)
    git_root=$(git -c gc.auto=0 rev-parse --show-toplevel 2>/dev/null)
    git_root_name=$(basename "$git_root")

    # Subpath relative to git root (empty string when cwd == git root)
    if [ -n "$git_root" ] && [ "$cwd" != "$git_root" ]; then
      git_subpath="${cwd#"${git_root}"/}"
    fi

    upstream=$(git -c gc.auto=0 rev-parse --abbrev-ref '@{upstream}' 2>/dev/null)
    if [ -n "$upstream" ]; then
      git_ahead=$(git -c gc.auto=0 rev-list --count "${upstream}..HEAD" 2>/dev/null)
      git_behind=$(git -c gc.auto=0 rev-list --count "HEAD..${upstream}" 2>/dev/null)
    fi
  fi
fi

# Rate limits
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_resets_at=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
week_resets_at=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

# Format reset times using local time
five_reset_str=""
if [ -n "$five_resets_at" ]; then
  five_reset_str=$(date -d "@${five_resets_at}" "+%H:%M" 2>/dev/null || date -r "$five_resets_at" "+%H:%M" 2>/dev/null)
fi

week_reset_str=""
if [ -n "$week_resets_at" ]; then
  week_reset_str=$(date -d "@${week_resets_at}" "+%a %H:%M" 2>/dev/null || date -r "$week_resets_at" "+%a %H:%M" 2>/dev/null)
fi

# Context window usage. used_percentage is pre-calculated by Claude Code; the
# absolute token count is derived from it × the window size (current_usage
# fields are often null, so we can't read tokens directly).
ctx_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')

# Session cost — lines added/removed
lines_added=$(echo "$input" | jq -r '.cost.total_lines_added // 0')
lines_removed=$(echo "$input" | jq -r '.cost.total_lines_removed // 0')

# Session cost — USD (only meaningful under API pricing; a subscription reports
# $0). total_cost_usd is cumulative across the transcript, so we subtract the
# baseline captured on the first render of the conversation to show only what
# this session spent. Keyed on transcript_path (stable per conversation) with a
# PPID fallback, so a fresh conversation always starts its delta from zero.
#
# Claude Code omits total_cost_usd on some refreshes and can briefly report a
# lower value, so the raw cumulative total is cached and kept monotonic (cost
# only ever grows) to bridge the gaps. Visibility is gated on that cumulative
# total (below), not the delta, so the segment shows for any API session and
# hides only on a true subscription ($0).
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
transcript_path=$(echo "$input" | jq -r '.transcript_path // empty')

_cost_key=$(printf '%s' "${transcript_path:-${PPID}}" | cksum | cut -d' ' -f1)
_baseline_file="/tmp/claude-cost-baseline-${_cost_key}"
_last_file="/tmp/claude-cost-last-${_cost_key}"

# Monotonic raw cumulative total, resilient to missing/dipping refreshes.
if [ -f "$_last_file" ]; then
  _last=$(cat "$_last_file")
  if [ -z "$cost" ]; then
    cost="$_last"
  else
    cost=$(awk -v c="$cost" -v l="$_last" 'BEGIN { print (c > l ? c : l) }')
  fi
fi

cost_total=""
if [ -n "$cost" ]; then
  printf '%s' "$cost" > "$_last_file"
  cost_total="$cost"
  # Baseline captured on first render of this conversation → per-session delta.
  if [ -f "$_baseline_file" ]; then
    _cost_baseline=$(cat "$_baseline_file")
  else
    _cost_baseline="$cost"
    printf '%s' "$_cost_baseline" > "$_baseline_file"
  fi
  cost=$(awk -v c="$cost" -v b="$_cost_baseline" 'BEGIN { v=c-b; printf "%.6f", (v>0?v:0) }')
fi

# ── Build LEFT parts (path:branch, ahead/behind) ────────────────────────────
left_parts=()

# Path display:
#   - In a git repo: `root:branch` or `root/subpath:branch` (git root name as
#     shorthand for the repo's full path)
#   - Outside a repo: full cwd path with $HOME abbreviated to `~`
# Soft green throughout.
if [ -n "$git_root_name" ] && [ -n "$git_branch" ]; then
  if [ -n "$git_subpath" ]; then
    path_display="${git_root_name}/${git_subpath}:${git_branch}"
  else
    path_display="${git_root_name}:${git_branch}"
  fi
  left_parts+=("$(printf '%b%s%b' "$C_GIT" "$path_display" "$RESET")")
elif [ -n "$cwd" ]; then
  if [ -n "$HOME" ] && [ "${cwd#"${HOME}"}" != "$cwd" ]; then
    path_display="~${cwd#"${HOME}"}"
  else
    path_display="$cwd"
  fi
  left_parts+=("$(printf '%b%s%b' "$C_GIT" "$path_display" "$RESET")")
fi

# Lines added/removed — yellow, shown only when > 0
diff_str=""
if [ -n "$lines_added" ] && [ "$lines_added" -gt 0 ] 2>/dev/null; then
  diff_str="+${lines_added}"
fi
if [ -n "$lines_removed" ] && [ "$lines_removed" -gt 0 ] 2>/dev/null; then
  if [ -n "$diff_str" ]; then
    diff_str="${diff_str} -${lines_removed}"
  else
    diff_str="-${lines_removed}"
  fi
fi
if [ -n "$diff_str" ]; then
  left_parts+=("$(printf '%b%s%b' "$C_DIFF" "$diff_str" "$RESET")")
fi

# Git ahead/behind — amber
git_changes=""
if [ -n "$git_ahead" ] && [ "$git_ahead" -gt 0 ] 2>/dev/null; then
  git_changes="${git_ahead}↑"
fi
if [ -n "$git_behind" ] && [ "$git_behind" -gt 0 ] 2>/dev/null; then
  git_changes="${git_changes}${git_behind}↓"
fi
if [ -n "$git_changes" ]; then
  left_parts+=("$(printf '%b%s%b' "$C_SYNC" "$git_changes" "$RESET")")
fi

# ── Build RIGHT parts (cost, 5h, 7d, ctx, model) ─────────────────────────────
right_parts=()

# Session cost — per-session delta, threshold-colored. Shown whenever the
# conversation has any API cost at all (cost_total > $0), so a $0.00 delta
# between renders keeps the segment visible; hidden only on a true subscription.
# Sits left of the rate limits; both can appear together (e.g. after 5h rollover
# onto API pricing).
if [ -n "$cost_total" ]; then
  total_cents=$(awk -v c="$cost_total" 'BEGIN { printf "%.0f", c * 100 }')
  if [ "$total_cents" -gt 0 ] 2>/dev/null; then
    cost_cents=$(awk -v c="$cost" 'BEGIN { printf "%.0f", c * 100 }')
    color=$(cost_color "$cost_cents")
    right_parts+=("$(printf '%b$%.2f%b' "$color" "$cost" "$RESET")")
  fi
fi

# Rate limits — threshold-colored percentage
if [ -n "$five_pct" ]; then
  color=$(rate_color "$five_pct")
  five_str="5h: $(printf '%b%.0f%%%b' "$color" "$five_pct" "$RESET")"
  if [ -n "$five_reset_str" ]; then
    five_str="${five_str} (${five_reset_str})"
  fi
  right_parts+=("$five_str")
fi

if [ -n "$week_pct" ]; then
  color=$(rate_color "$week_pct")
  week_str="7d: $(printf '%b%.0f%%%b' "$color" "$week_pct" "$RESET")"
  if [ -n "$week_reset_str" ]; then
    week_str="${week_str} (${week_reset_str})"
  fi
  right_parts+=("$week_str")
fi

# Context window usage — threshold-colored, with absolute token count when the
# window size is known: "ctx: 36k (18%)". Falls back to just the percentage.
if [ -n "$ctx_pct" ]; then
  color=$(rate_color "$ctx_pct")
  if [ -n "$ctx_size" ]; then
    ctx_tokens=$(awk -v pct="$ctx_pct" -v size="$ctx_size" 'BEGIN { printf "%.0f", pct/100 * size }')
    if [ "$ctx_tokens" -ge 1000000 ] 2>/dev/null; then
      ctx_display=$(awk -v t="$ctx_tokens" 'BEGIN { printf "%.1fm", t/1000000 }')
    else
      ctx_display=$(awk -v t="$ctx_tokens" 'BEGIN { printf "%.0fk", t/1000 }')
    fi
    right_parts+=("ctx: $(printf '%b%s (%.0f%%)%b' "$color" "$ctx_display" "$ctx_pct" "$RESET")")
  else
    right_parts+=("ctx: $(printf '%b%.0f%%%b' "$color" "$ctx_pct" "$RESET")")
  fi
fi

# Model — steel blue
right_parts+=("$(printf '%b%s%b' "$C_MODEL" "$model" "$RESET")")

# ── Join each group with colored separator ───────────────────────────────────
sep="$(printf '%b | %b' "$C_SEP" "$RESET")"

join_parts() {
  local out=""
  local part
  for part in "$@"; do
    if [ -z "$out" ]; then
      out="$part"
    else
      out="${out}${sep}${part}"
    fi
  done
  printf '%s' "$out"
}

left_str=$(join_parts "${left_parts[@]}")
right_str=$(join_parts "${right_parts[@]}")

# ── Pad between left and right to fill terminal width ───────────────────────
left_vis=$(visible_len "$left_str")
right_vis=$(visible_len "$right_str")
# Minimum 1 space of padding
pad=$(( term_width - left_vis - right_vis ))
[ "$pad" -lt 1 ] && pad=1
padding=$(printf '%*s' "$pad" '')

printf '%b%s%b\n' "" "${left_str}${padding}${right_str}" ""
