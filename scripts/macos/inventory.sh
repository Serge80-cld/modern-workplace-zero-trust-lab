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
