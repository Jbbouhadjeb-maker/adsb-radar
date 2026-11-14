# F4MYH · ADS-B Radar

Radar ADS-B local pour macOS avec une clé RTL-SDR V3.

## Installation en un clic

1. Télécharge le projet depuis GitHub.
2. Ouvre le dossier téléchargé.
3. Double-clique sur `install.command`.
4. Autorise l’installation de Homebrew si macOS le demande.
5. Branche la RTL-SDR V3, puis laisse la fenêtre Terminal ouverte.

L’installeur installe automatiquement Homebrew, Python et `dump1090-fa`, puis lance le récepteur et le radar.

## Lancement manuel

```bash
cd adsb-radar
./start-radar.command
```

Le radar est ensuite disponible sur <http://localhost:8765>.

## Dépendances

- macOS ;
- clé RTL-SDR V3 ;
- Homebrew ;
- dump1090-fa ;
- Python 3.

Les données de réception dans `data/` sont générées localement et ne sont pas versionnées.
