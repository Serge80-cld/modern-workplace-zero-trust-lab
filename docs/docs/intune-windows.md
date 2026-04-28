Intune — Déploiement de scripts PowerShell (Windows)
Objectif
Documenter la méthode professionnelle pour déployer des scripts PowerShell via Microsoft Intune, en mode SYSTEM, avec logs IME et troubleshooting.

1. Préparation du script PowerShell
Un script destiné à Intune doit respecter :

aucune interaction utilisateur (Read-Host, Pause, GUI…)

chemins compatibles SYSTEM (C:\ProgramData\…)

logs écrits dans un dossier accessible

pas de dépendance à un profil utilisateur

Exemple de script de test :
powershell
$path = "C:\ProgramData\Intune-Test"
New-Item -ItemType Directory -Path $path -Force | Out-Null

$log = "$path\execution.log"
"Script exécuté sur $env:COMPUTERNAME à $(Get-Date)" | Out-File -FilePath $log -Append -Encoding UTF8
2. Import du script dans Intune
Intune Admin Center → Devices → Scripts → Add → Windows PowerShell

Paramètres recommandés :

Paramètre	Valeur
Run this script using logged-on credentials	No
Run script in 64-bit PowerShell	Yes
Environnement d’exécution	SYSTEM
Assignation	Groupe de test ou All devices


3. Vérification de l’exécution
Dossier créé par le script
Code
C:\ProgramData\Intune-Test\
Log généré
Code
C:\ProgramData\Intune-Test\execution.log
4. Logs Intune Management Extension (IME)
Tous les scripts PowerShell passent par l’agent IME.

Dossier :

Code
C:\ProgramData\Microsoft\IntuneManagementExtension\Logs
Fichiers importants :

IntuneManagementExtension.log → exécution des scripts

AgentExecutor.log → détails d’exécution

Script.log → logs spécifiques

5. Troubleshooting
Problème	Cause	Solution
Script non exécuté	Pas assigné	Vérifier les groupes
Pas de log	Script non SYSTEM	Run as SYSTEM = No
Erreur 0x87D300C9	Script trop long	Ajouter des logs internes
Script OK mais pas d’effet	Chemins utilisateur	Utiliser ProgramData


6. Conclusion
Cette section démontre :

la maîtrise du packaging Intune Windows

l’exécution SYSTEM

l’analyse des logs IME

la capacité à déployer des scripts en entreprise
