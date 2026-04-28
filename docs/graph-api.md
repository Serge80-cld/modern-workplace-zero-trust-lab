DOCUMENTATION GRAPH API — graph-api.md


Graph API — Documentation Technique
Objectif
Ce document présente l’utilisation de Microsoft Graph API dans le cadre du lab Modern Workplace / Zero Trust.
Il couvre :

l’installation du module Graph PowerShell

la connexion sécurisée

les permissions (scopes)

les scripts utilisés (Users, Devices, Autopilot)

les bonnes pratiques

les erreurs courantes et leur résolution

1. Installation du module Microsoft Graph
powershell
Install-Module Microsoft.Graph -Scope AllUsers
Vérification :

powershell
Get-Module Microsoft.Graph -ListAvailable
2. Connexion à Microsoft Graph
Chaque script utilise une connexion avec des scopes spécifiques :

powershell
Connect-MgGraph -Scopes "User.Read.All"
Exemples de scopes utilisés dans ce lab :

Script	Scope
Audit Licences	User.Read.All
Devices non conformes	DeviceManagementManagedDevices.Read.All
Autopilot	DeviceManagementServiceConfig.Read.All


3. Script : Audit des licences utilisateurs
powershell
Import-Module Microsoft.Graph.Users

Connect-MgGraph -Scopes "User.Read.All"

$allUsers = Get-MgUser -All -Property "id,displayName,userPrincipalName"

$result = foreach ($u in $allUsers) {
    $licenses = Get-MgUserLicenseDetail -UserId $u.Id
    [PSCustomObject]@{
        DisplayName       = $u.displayName
        UserPrincipalName = $u.userPrincipalName
        Licences          = ($licenses.SkuPartNumber -join ",")
    }
}

$result | Export-Csv -Path ".\Licences-Audit.csv" -NoTypeInformation -Encoding UTF8
4. Script : Appareils non conformes (Intune)
powershell
Import-Module Microsoft.Graph.DeviceManagement

Connect-MgGraph -Scopes "DeviceManagementManagedDevices.Read.All"

$nonCompliantDevices = Get-MgDeviceManagementManagedDevice -Filter "complianceState ne 'compliant'"

$nonCompliantDevices |
    Select-Object deviceName, operatingSystem, complianceState, userPrincipalName |
    Format-Table -AutoSize
5. Script : Export des appareils Autopilot
powershell
Import-Module Microsoft.Graph.DeviceManagement

Connect-MgGraph -Scopes "DeviceManagementServiceConfig.Read.All"

$devices = Get-MgDeviceManagementWindowsAutopilotDeviceIdentity -All

$devices |
    Select-Object serialNumber, manufacturer, model, groupTag, purchaseOrderIdentifier |
    Export-Csv -Path ".\Autopilot-Devices.csv" -NoTypeInformation -Encoding UTF8
6. Bonnes pratiques Graph API
Toujours utiliser des scopes minimaux

Ne jamais stocker de credentials en clair

Utiliser -All pour récupérer toutes les pages

Toujours tester les scripts dans un tenant de lab

Exporter les résultats en CSV ou JSON pour audit

7. Erreurs courantes
Erreur	Cause	Solution
Access Denied	Scope insuffisant	Ajouter le scope correct
No output	Tenant vide	Normal dans un lab
Module not found	Module non installé	Install-Module Microsoft.Graph
Login window appears	Auth interactive	Normal pour Graph


8. Conclusion
Cette section du lab démontre :

la maîtrise de Microsoft Graph API

la capacité à interroger Entra ID, Intune et Autopilot

la création de scripts PowerShell professionnels

la structuration d’un environnement Modern Workplace
