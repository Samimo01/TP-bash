#!/bin/bash

# Seuil 80 par défaut
SEUIL=${1:-80}

# Pourcentage d'utilisation de la partition /
UTILISATION=$( df / | tail -1 | awk '{print $5}' | tr -d '%')

# Si UTILISATION > SEUIL
if [ "$UTILISATION" -ge "$SEUIL" ]; then
    echo "ALERTE : l'espace disque utilisé est de ${UTILISATION}% (seuil : ${SEUIL}%)"
    exit 1
fi

echo "OK : l'espace disque utilisé est de ${UTILISATION}% (seuil : ${SEUIL}%)"
exit 0

# SAMY@MSI MINGW64 /d/ETUDES/Cours/ING5/S9/DevOps/TP/TP-bash (main)
# $ ./scripts/check_disk.sh
# ALERTE : l'espace disque utilisé est de 11499540% (seuil : 80%)

# SAMY@MSI MINGW64 /d/ETUDES/Cours/ING5/S9/DevOps/TP/TP-bash (main)
# $ ./scripts/check_disk.sh 10
# ALERTE : l'espace disque utilisé est de 11499536% (seuil : 10%)