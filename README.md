# F4MYH · ADS-B Radar

Radar ADS-B local pour macOS avec une clé RTL-SDR V3.

## Installation macOS

1. Télécharge le projet depuis GitHub.
2. Ouvre le dossier téléchargé.
3. Double-clique sur `install.command`.
4. Autorise l’installation de Homebrew si macOS le demande.
5. Branche la RTL-SDR V3, puis laisse la fenêtre Terminal ouverte.

L’installeur installe automatiquement Homebrew, Python et `dump1090-fa`, puis lance le récepteur et le radar.

Les deux raccourcis suivants sont également disponibles :

- `install-mac-v3.command` pour une RTL-SDR V3 ;
- `install-mac-v5.command` pour une RTL-SDR V5.

Les deux modèles utilisent le même pilote RTL-SDR sous macOS.

## Installation Windows

1. Télécharge le projet depuis GitHub.
2. Ouvre PowerShell dans le dossier du projet.
3. Autorise les scripts pour ton compte si nécessaire :

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

4. Lance :

```powershell
.\install-windows.ps1
```

5. Installe le pilote **WinUSB** avec [Zadig](https://zadig.akeo.ie/) en sélectionnant `RTL2832U / Bulk-In, Interface 0`.
6. Double-clique sur `start-windows.bat`.

Le parcours Windows fonctionne avec les RTL-SDR V3 et V5. La première installation du pilote USB doit être confirmée manuellement dans Zadig.

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
