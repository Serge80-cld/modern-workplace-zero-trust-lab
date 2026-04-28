Conformité macOS — Script compliance.sh
Objectif
Vérifier les éléments de sécurité essentiels d’un Mac dans un contexte Zero Trust :

FileVault

Gatekeeper

SIP

Firewall

XProtect

MRT

Secure Boot

Activation Lock

Version macOS

1. Contenu du script
bash
#!/bin/bash

OUTPUT="/tmp/mac_compliance.json"

filevault=$(fdesetup status | grep -o "FileVault is .\+")
gatekeeper=$(spctl --status 2>&1)
sip=$(csrutil status 2>&1)
firewall=$(defaults read /Library/Preferences/com.apple.alf globalstate 2>/dev/null)
xprotect=$(defaults read /System/Library/CoreServices/XProtect.bundle/Contents/Info.plist CFBundleShortVersionString 2>/dev/null)
mrt=$(defaults read /System/Library/CoreServices/MRT.app/Contents/Info.plist CFBundleShortVersionString 2>/dev/null)
secure_boot=$(system_profiler SPiBridgeDataType 2>/dev/null | awk -F": " '/Secure Boot/ {print $2}')
activation_lock=$(system_profiler SPHardwareDataType | awk -F": " '/Activation Lock Status/ {print $2}')
os_version=$(sw_vers -productVersion)
user=$(stat -f%Su /dev/console)

cat <<EOF > "$OUTPUT"
{
  "filevault_status": "$filevault",
  "gatekeeper_status": "$gatekeeper",
  "sip_status": "$sip",
  "firewall_state": "$firewall",
  "xprotect_version": "$xprotect",
  "mrt_version": "$mrt",
  "secure_boot": "$secure_boot",
  "activation_lock": "$activation_lock",
  "os_version": "$os_version",
  "logged_user": "$user"
}
EOF

echo "Rapport de conformité généré : $OUTPUT"
2. Exécution locale
Code
chmod +x compliance.sh
./compliance.sh
Résultat :

Code
Rapport de conformité généré : /tmp/mac_compliance.json
3. Exemple de sortie JSON
json
{
  "filevault_status": "FileVault is On.",
  "gatekeeper_status": "assessments enabled",
  "sip_status": "System Integrity Protection status: enabled",
  "firewall_state": "1",
  "xprotect_version": "2165",
  "mrt_version": "1.93",
  "secure_boot": "Full Security",
  "activation_lock": "Enabled",
  "os_version": "14.4",
  "logged_user": "serge"
}
4. Utilisation dans Intune
Déploiement via Devices → macOS → Shell scripts

Exécution en root

Résultats dans /tmp/mac_compliance.json

Analyse via logs :

/Library/Logs/Microsoft/Intune

/var/log/intune

5. Conclusion
Ce script fournit un rapport de conformité complet, essentiel pour :

Zero Trust

audits sécurité

durcissement macOS

reporting

automatisation
