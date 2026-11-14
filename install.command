#!/bin/zsh

set -e

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "Cet installeur est prévu pour macOS."
  read -r "?Appuie sur Entrée pour fermer..."
  exit 1
fi

echo "Installation du radar ADS-B F4MYH"
echo ""

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew est absent. Installation de Homebrew…"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

echo "Installation des dépendances…"
brew install dump1090-fa python

mkdir -p "$PROJECT_DIR/data"
chmod +x "$PROJECT_DIR/start-radar.command"

echo "Installation terminée. Lancement du radar…"
open "$PROJECT_DIR/start-radar.command"
