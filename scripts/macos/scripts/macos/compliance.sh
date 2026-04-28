#!/bin/bash

OUTPUT="/tmp/mac_compliance.json"

# FileVault
filevault=$(fdesetup status | grep -o "FileVault is .\+")

# Gatekeeper
gatekeeper=$(spctl --status 2>&1)

# SIP (System Integrity Protection)
sip=$(csrutil status 2>&1)

# Firewall
firewall=$(defaults read /Library/Preferences/com.apple.alf globalstate 2>/dev/null)

# XProtect version
xprotect=$(defaults read /System/Library/CoreServices/XProtect.bundle/Contents/Info.plist CFBundleShortVersionString 2>/dev/null)

# MRT version
mrt=$(defaults read /System/Library/CoreServices/MRT.app/Contents/Info.plist CFBundleShortVersionString 2>/dev/null)

# Secure Boot (T2 / Apple Silicon)
secure_boot=$(system_profiler SPiBridgeDataType 2>/dev/null | awk -F": " '/Secure Boot/ {print $2}')

# Activation Lock
activation_lock=$(system_profiler SPHardwareDataType | awk -F": " '/Activation Lock Status/ {print $2}')

# OS version
os_version=$(sw_vers -productVersion)

# Logged user
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
