Inventaire macOS — Script inventory.sh
Objectif
Collecter les informations essentielles d’un Mac pour un usage Modern Workplace / Intune / Zero Trust.

Ce script permet d’obtenir :

Nom de l’appareil

Numéro de série

Modèle

Version macOS

Utilisateur connecté

Adresse IP

Uptime

Stockage total / libre

État FileVault

1. Contenu du script
bash
#!/bin/bash

OUTPUT="/tmp/mac_inventory.json"

serial=$(system_profiler SPHardwareDataType | awk '/Serial Number/ {print $4}')
model=$(system_profiler SPHardwareDataType | awk -F": " '/Model Name/ {print $2}')
os_version=$(sw_vers -productVersion)
hostname=$(scutil --get ComputerName)
user=$(stat -f%Su /dev/console)
ip=$(ipconfig getifaddr en0)
uptime=$(uptime | sed 's/.*up \([^,]*\), .*/\1/')
disk_total=$(df -H / | awk 'NR==2 {print $2}')
disk_free=$(df -H / | awk 'NR==2 {print $4}')
filevault=$(fdesetup status | grep -o "FileVault is .\+")

cat <<EOF > "$OUTPUT"
{
  "hostname": "$hostname",
  "serial_number": "$serial",
  "model": "$model",
  "os_version": "$os_version",
  "logged_user": "$user",
  "ip_address": "$ip",
  "uptime": "$uptime",
  "disk_total": "$disk_total",
  "disk_free": "$disk_free",
  "filevault_status": "$filevault"
}
EOF

echo "Inventaire généré : $OUTPUT"
2. Exécution locale (sur un Mac)
Code
chmod +x inventory.sh
./inventory.sh
Résultat :

Code
Inventaire généré : /tmp/mac_inventory.json
3. Exemple de sortie JSON
json
{
  "hostname": "MacBook-Pro",
  "serial_number": "C02XXXXXXX",
  "model": "MacBook Pro",
  "os_version": "14.4",
  "logged_user": "serge",
  "ip_address": "192.168.1.20",
  "uptime": "3 days",
  "disk_total": "500G",
  "disk_free": "320G",
  "filevault_status": "FileVault is On."
}
4. Utilisation dans Intune
Déploiement via Devices → macOS → Shell scripts

Exécution en root

Fréquence : toutes les 1h

Résultats visibles dans /tmp/mac_inventory.json

5. Conclusion
Ce script fournit un inventaire complet, exploitable pour :

audits

conformité

automatisation

Zero Trust

reporting
