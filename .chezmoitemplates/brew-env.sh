# Shared shell helper: put Homebrew on PATH and resolve op.
# Included at the top of run_ scripts via a chezmoi template directive.
if [[ $(uname -m) == "arm64" ]]; then
  BREW_PREFIX="/opt/homebrew"
else
  BREW_PREFIX="/usr/local"
fi
BREW_BIN="$BREW_PREFIX/bin/brew"

if [ -x "$BREW_BIN" ]; then
  eval "$("$BREW_BIN" shellenv)"
fi

# Absolute path to op, so scripts don't depend on PATH ordering.
if [ -x "$BREW_PREFIX/bin/op" ]; then
  OP="$BREW_PREFIX/bin/op"
elif command -v op &>/dev/null; then
  OP="$(command -v op)"
else
  OP=""
fi
