#!/usr/bin/env bash
# Claude Code Starter Kit installer.
# Installs the global config in this repo into ~/.claude/ — safely.
# - Never destroys existing files: anything it would overwrite is backed up first.
# - Renders settings.json with absolute paths for THIS machine (hooks require them).
# - Idempotent: re-running just refreshes from the repo (with a fresh backup).

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$REPO_DIR/claude"
CLAUDE_DIR="$HOME/.claude"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="$CLAUDE_DIR/backup-$STAMP"

say()  { printf '\033[1;36m▸ %s\033[0m\n' "$*"; }
warn() { printf '\033[1;33m! %s\033[0m\n' "$*"; }
ok()   { printf '\033[1;32m✓ %s\033[0m\n' "$*"; }

# --- preflight ---------------------------------------------------------------
missing=()
command -v jq      >/dev/null 2>&1 || missing+=("jq")
command -v python3 >/dev/null 2>&1 || missing+=("python3")
if [ "${#missing[@]}" -gt 0 ]; then
  warn "Missing prerequisites: ${missing[*]}"
  warn "The safety hooks need these. Install them, then re-run. (macOS: brew install ${missing[*]})"
  exit 1
fi

say "Installing Claude Code Starter Kit into $CLAUDE_DIR"
mkdir -p "$CLAUDE_DIR"

backup_if_exists() {
  local target="$1"
  if [ -e "$target" ]; then
    mkdir -p "$BACKUP_DIR"
    local rel="${target#"$CLAUDE_DIR"/}"
    mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
    cp -R "$target" "$BACKUP_DIR/$rel"
  fi
}

# --- CLAUDE.md + ARCHITECTURE.md --------------------------------------------
for f in CLAUDE.md ARCHITECTURE.md; do
  backup_if_exists "$CLAUDE_DIR/$f"
  cp "$SRC/$f" "$CLAUDE_DIR/$f"
  ok "installed $f"
done

# --- rules/ ------------------------------------------------------------------
mkdir -p "$CLAUDE_DIR/rules"
for f in "$SRC"/rules/*.md; do
  name="$(basename "$f")"
  backup_if_exists "$CLAUDE_DIR/rules/$name"
  cp "$f" "$CLAUDE_DIR/rules/$name"
done
ok "installed rules/ ($(ls -1 "$SRC"/rules/*.md | wc -l | tr -d ' ') files)"

# --- hooks/ ------------------------------------------------------------------
mkdir -p "$CLAUDE_DIR/hooks"
for f in "$SRC"/hooks/*.sh; do
  name="$(basename "$f")"
  backup_if_exists "$CLAUDE_DIR/hooks/$name"
  cp "$f" "$CLAUDE_DIR/hooks/$name"
  chmod +x "$CLAUDE_DIR/hooks/$name"
done
ok "installed hooks/ (made executable)"

# --- settings.json (render absolute paths) ----------------------------------
# Hook commands must be absolute paths. Substitute the placeholder with this
# machine's real ~/.claude path. (sed, not a heredoc — portable to macOS bash 3.2.)
tmp_settings="$(mktemp)"
sed "s|__CLAUDE_DIR__|$CLAUDE_DIR|g" "$SRC/settings.template.json" > "$tmp_settings"

# Validate it's well-formed JSON before installing anything.
if ! python3 -c "import json,sys; json.load(open(sys.argv[1]))" "$tmp_settings" 2>/dev/null; then
  warn "Rendered settings.json is not valid JSON — aborting the settings step."
  rm -f "$tmp_settings"
else
  if [ -f "$CLAUDE_DIR/settings.json" ]; then
    backup_if_exists "$CLAUDE_DIR/settings.json"
    # Don't clobber an existing settings.json — the user may have permissions /
    # MCP servers / plugins configured. Write alongside and let them merge.
    mv "$tmp_settings" "$CLAUDE_DIR/settings.json.from-starter"
    warn "You already have ~/.claude/settings.json — left it untouched."
    warn "The starter version was written to ~/.claude/settings.json.from-starter"
    warn "Merge the \"hooks\", \"permissions\", and \"env\" blocks you want into your existing file."
  else
    mv "$tmp_settings" "$CLAUDE_DIR/settings.json"
    ok "installed settings.json (hooks wired with absolute paths)"
  fi
fi

echo
if [ -d "$BACKUP_DIR" ]; then
  ok "Done. Anything overwritten was backed up to: $BACKUP_DIR"
else
  ok "Done. (Nothing existing was overwritten — clean install.)"
fi
say "Start a new Claude Code session to load the config."
