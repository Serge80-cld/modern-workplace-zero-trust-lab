# Fiche Technique — Modern Workplace Zero Trust Lab  
Windows Autopilot + Intune + ESP

---

## 1.  Objectif du lab

Mettre en place un pipeline de déploiement moderne basé sur :

- Windows Autopilot  
- Microsoft Intune  
- Microsoft Entra ID  
- Enrollment Status Page (ESP)  
- Principes Zero Trust  

Le tout **sans réinitialiser le poste local**, grâce à l’import du Hardware Hash.

---

## 2.  Architecture du lab

- Microsoft Entra ID (Azure AD)  
- Microsoft Intune  
- Windows Autopilot  
- ESP (Enrollment Status Page)  
- Groupe de test : Zero Trust – Test  
- PC Windows 11 (hash importé, non réinitialisé)

---

## 3.  Étapes techniques

### 3.1 Création du groupe Zero Trust – Test
- Type : Groupe de sécurité  
- Nom : **Zero Trust – Test**  
- Usage : isoler les tests Autopilot/ESP  
- Raison : éviter tout impact sur d’autres appareils

---

### 3.2 Stratégie de conformité Windows 10/11
- Plateforme : Windows 10/11  
- Paramètres : configuration par défaut  
- Action en cas de non‑conformité : **immédiate (0 jours)**  
- Affectation : **Zero Trust – Test**

Objectif : activer la conformité comme prérequis pour l’accès conditionnel.

---

### 3.3 Récupération du Hardware Hash

Commandes PowerShell :

```powershell
md C:\HWID
Install-Script -Name Get-WindowsAutopilotInfo -Force
& "C:\Program Files\WindowsPowerShell\Scripts\Get-WindowsAutopilotInfo.ps1" -OutputFile C:\HWID\AutopilotHWID.csv
3.4 Import du Hardware Hash dans Intune
Intune → Appareils → Inscription → Windows Autopilot → Appareils

Action : Importer

Fichier : AutopilotHWID.csv

Résultat : appareil visible dans la liste

3.5 Création du profil Autopilot
Nom : Autopilot – Windows 11 – Zero Trust
Paramètres :

Mode : User‑Driven

Jonction : Azure AD Join

Masquer EULA : Oui

Masquer confidentialité : Oui

Masquer sélection clavier : Oui

Type de compte : Standard

WhiteGlove : Non

Affectation : Zero Trust – Test

Objectif : automatiser l’OOBE et forcer la jonction Azure AD.

3.6 Création de l’ESP (Enrollment Status Page)
Nom : ESP – Zero Trust
Paramètres :

Afficher la progression : Oui

Bloquer l’accès tant que les apps obligatoires ne sont pas installées : Oui

Autoriser la réinitialisation en cas d’erreur : Oui

Affectation : Zero Trust – Test

Objectif : garantir que le PC est conforme avant utilisation.

4.  Concepts Zero Trust appliqués
Identity-first (Azure AD Join)

Device compliance obligatoire

Blocage de l’accès tant que la sécurité n’est pas appliquée (ESP)

Principe du moindre privilège (compte standard)

Automatisation du provisioning

Gouvernance via groupes dédiés

5.  Structure recommandée du dépôt
Code
/Modern-Workplace-ZeroTrust-Lab
   /docs
      fiche-technique.md
      architecture.png
   /intune
      autopilot-profile.json
      esp-profile.json
   /scripts
      autopilot-hwid.ps1
   README.md
6.  Auteur
Serge Ngindu
Cloud & Modern Workplace Engineer
