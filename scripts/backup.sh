#!/bin/bash

set -Eeuo pipefail

DOSSIER="${1:-}"
DESTINATION="${2:-./backups}"
JOURS=7

#  Vérifications 

## parametre 'DOSSIER' non saisi
if [ -z "$DOSSIER" ]; then
    echo "Usage : $0 <dossier_a_sauvegarder> [dossier_destination]" >&2
    exit 1
fi

## dossier non-existant
if [ ! -d "$DOSSIER" ]; then
    echo "Erreur : le dossier '$DOSSIER' n'existe pas" >&2
    exit 1
fi

#  Création de l'archive horodatée 
mkdir -p "$DESTINATION"
HORODATAGE=$(date +%Y-%m-%d_%H-%M-%S)
NOM=$(basename "$DOSSIER")
ARCHIVE="$DESTINATION/${NOM}_${HORODATAGE}.tar.gz"

#  Archivage
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Sauvegarde de '$DOSSIER' vers '$ARCHIVE'"
tar -czf "$ARCHIVE" -C "$(dirname "$DOSSIER")" "$NOM"
echo "Archive créée : $(du -h "$ARCHIVE" | cut -f1)"

#  Suppression des sauvegardes de plus de 7 jours 
for fichier in "$DESTINATION"/"${NOM}"_*.tar.gz; do
    [ -e "$fichier" ] || continue
    if [ -n "$(find "$fichier" -mtime +"$JOURS")" ]; then
        echo "Suppression de l'ancienne sauvegarde : $fichier"
        rm "$fichier"
    fi
done

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Sauvegarde terminée"
exit 0


# SAMY@MSI MINGW64 /d/ETUDES/Cours/ING5/S9/DevOps/TP/TP-bash (main)
# $ ./scripts/backup.sh ./data
# [2026-11-08 19:37:24] Sauvegarde de './data' vers './backups/data_2026-11-08_19-37-24.tar.gz'
# Archive créée : 1.0K
# [2026-11-08 19:37:24] Sauvegarde terminée