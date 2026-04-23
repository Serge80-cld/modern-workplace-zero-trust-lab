# Modern Workplace – Zero Trust Lab  
Déploiement Windows Autopilot + Intune + ESP

Ce projet démontre la mise en place d’un pipeline de déploiement moderne basé sur Windows Autopilot, Microsoft Intune et les principes Zero Trust.  
L’ensemble du lab a été réalisé sans impacter le poste local, grâce à l’import du Hardware Hash sans réinitialisation.

---

##  Objectif du projet

L’objectif de ce lab est de mettre en place un déploiement moderne (Modern Deployment) permettant :

- d’enregistrer un appareil dans Windows Autopilot  
- d’automatiser l’OOBE (Out‑Of‑Box Experience)  
- de forcer la jonction Azure AD  
- d’inscrire automatiquement l’appareil dans Intune  
- de garantir la conformité via une ESP (Enrollment Status Page)  
- d’appliquer les principes Zero Trust dès le premier démarrage  

Ce lab constitue une base solide pour tout environnement Modern Workplace.

---

##  Architecture du lab

- **Microsoft Entra ID (Azure AD)**  
- **Microsoft Intune**  
- **Windows Autopilot**  
- **Enrollment Status Page (ESP)**  
- **Groupe de test : Zero Trust – Test**  
- **PC Windows 11 (hash importé, non réinitialisé)**  

---

## 🛠️ Étapes réalisées

### 1. Création du groupe Zero Trust – Test
- Groupe de sécurité dédié aux tests  
- Permet d’isoler les configurations Autopilot/ESP  
- Bonne pratique de gouvernance Intune  

---

### 2. Stratégie de conformité Windows 10/11
- Paramètres par défaut  
- Marquer comme non conforme immédiatement  
- Affectée au groupe **Zero Trust – Test**  
- Préparation pour l’accès conditionnel  

---

### 3. Récupération du Hardware Hash

Commandes PowerShell utilisées :

```powershell
md C:\HWID
Install-Script -Name Get-WindowsAutopilotInfo -Force
& "C:\Program Files\WindowsPowerShell\Scripts\Get-WindowsAutopilotInfo.ps1" -OutputFile C:\HWID\AutopilotHWID.csv

