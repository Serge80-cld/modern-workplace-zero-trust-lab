Proactive Remediations — Intune
Objectif
Mettre en place des scripts Check (détection) et Remediate (correction) permettant d’identifier et corriger automatiquement des problèmes sur les postes Windows via Intune.

Les Proactive Remediations sont un pilier du Modern Workplace :
auto‑réparation
conformité
réduction des tickets
standardisation des postes

1. Fonctionnement général
Une remédiation Intune contient 2 scripts :

Script Check
Analyse l’état du poste

Retourne :

0 → conforme

1 → non conforme

Ne modifie rien

Script Remediate
S’exécute uniquement si Check retourne 1

Corrige le problème

Peut redémarrer un service, créer une clé de registre, appliquer une configuration…

2. Cycle d’exécution
S’exécute toutes les 1h par défaut

Fonctionne via l’agent Intune Management Extension (IME)

Logs disponibles dans :

Code
C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\Remediation*.log
3. Cas d’usage courants
Service critique arrêté

Application manquante

Clé de registre incorrecte

Paramètre de sécurité désactivé

Agent de sécurité non fonctionnel

Nettoyage de fichiers temporaires

Réparation de OneDrive / Teams / Office

4. Exemple concret : Service critique
✔️ Objectif
Vérifier que le service Windows Update (wuauserv) est démarré.
Le démarrer automatiquement si nécessaire.

5. Script Check (détection)
powershell
$service = Get-Service -Name "wuauserv" -ErrorAction SilentlyContinue

if ($service -and $service.Status -eq "Running") {
    Write-Output "Service OK"
    exit 0
} else {
    Write-Output "Service not running"
    exit 1
}
6. Script Remediate (correction)
powershell
$service = Get-Service -Name "wuauserv" -ErrorAction SilentlyContinue

if ($service) {
    Start-Service -Name "wuauserv"
    Write-Output "Service started"
} else {
    Write-Output "Service not found"
}
7. Structure recommandée dans ton repo
Code
scripts/remediations/
    ├── Check-Service.ps1
    └── Remediate-Service.ps1
8. Import dans Intune
Intune Admin Center → Reports → Endpoint Analytics → Proactive Remediations → Create script package

Paramètres :

Section	Valeur
Detection script	Check-Service.ps1
Remediation script	Remediate-Service.ps1
Run as	64-bit PowerShell
Run as account	SYSTEM
Schedule	Hourly


9. Best practices entreprise
Toujours écrire des scripts idempotents (répétables sans risque)

Toujours logguer les actions

Toujours tester sur un groupe pilote

Toujours documenter le comportement attendu

Toujours prévoir un rollback si nécessaire

10. Conclusion
Cette brique démontre :

ta maîtrise des Proactive Remediations

ta capacité à automatiser la conformité

ta compréhension de l’IME

ta capacité à structurer des scripts entreprise

C’est une compétence très recherchée en Modern Workplace.
