#!/bin/zsh

set -u

PROJECT_DIR="/Users/jean-baptistebouhadjeb/adsb-radar"
DATA_DIR="$PROJECT_DIR/data"
PORT="8765"

cd "$PROJECT_DIR" || exit 1

DUMP1090="$(command -v dump1090 2>/dev/null || true)"
if [[ -z "$DUMP1090" ]]; then
  echo "dump1090 est introuvable. Installe-le avec : brew install dump1090"
  read -r "?Appuie sur Entrée pour fermer..."
  exit 1
fi

if pgrep -f "dump1090.*--write-json[ =]$DATA_DIR" >/dev/null 2>&1; then
  echo "Un récepteur dump1090 utilise déjà la clé RTL-SDR."
  echo "Arrête-le avant de relancer ce lanceur si tu veux le mode interactif."
  read -r "?Appuie sur Entrée pour fermer..."
  exit 1
fi

echo "Démarrage du récepteur RTL-SDR V3 en mode interactif..."
echo "Le radar web s'ouvrira dans quelques secondes."

python3 -m http.server "$PORT" --bind 127.0.0.1 >/tmp/adsb-radar-http.log 2>&1 &
WEB_PID=$!
trap 'kill "$WEB_PID" 2>/dev/null || true' EXIT INT TERM
sleep 1
open "http://localhost:$PORT/" 2>/dev/null || true
echo "Serveur web actif. Laisse cette fenêtre ouverte pour garder le radar actif."

exec "$DUMP1090" \
  --device-type rtlsdr \
  --interactive \
  --net \
  --net-bind-address 127.0.0.1 \
  --write-json "$DATA_DIR" \
  --write-json-every 1 \
  --json-stats-every 10
