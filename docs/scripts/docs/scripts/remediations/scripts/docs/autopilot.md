# Windows Autopilot — Profil, ESP, Tests

## Objectif
Documenter la mise en place d’un scénario Windows Autopilot moderne : profils, ESP, tests et export des devices via Microsoft Graph.

---

## 1. Concepts clés

- **Autopilot** : provisioning moderne basé sur l’identité (Entra ID + Intune)
- **Profil Autopilot** : définit l’expérience OOBE (user-driven, pre-provisioned, etc.)
- **ESP (Enrollment Status Page)** : contrôle ce qui doit être installé avant que l’utilisateur accède au bureau
- **Device registration** : enregistrement du device dans Autopilot (CSV, OEM, Graph)

---

## 2. Types de scénarios

- **User-driven** : l’utilisateur sort le PC du carton et se connecte avec son compte
- **Pre-provisioned (anciennement WhiteGlove)** : préparation en atelier, finalisation par l’utilisateur
- **Self-deploying** : scénarios kiosque / shared device

---

## 3. Profil Autopilot

Exemple de paramètres recommandés :

- Skip privacy settings : Yes  
- Skip EULA : Yes  
- Skip keyboard selection : Yes  
- User account type : Standard  
- Allow WhiteGlove : Yes (si utilisé)  
- Language/Region : User selectable ou forcé

---

## 4. ESP (Enrollment Status Page)

Paramètres typiques :

- Block device use until required apps are installed : Yes  
- Show ESP for all users : Yes  
- Track these apps as required :  
  - Agent sécurité  
  - Outils de base (Office, OneDrive, etc.)  
  - Scripts critiques (configuration, sécurité)

---

## 5. Export des devices Autopilot via Graph

Un script PowerShell peut être utilisé pour :

- lister les devices Autopilot  
- exporter en CSV  
- auditer l’inventaire

Voir : `scripts/graph/Export-AutopilotDevices.ps1`.

---

## 6. Tests

- Tester avec une VM ou un device de lab  
- Vérifier :
  - attribution du profil Autopilot  
  - bon déroulement de l’ESP  
  - installation des apps requises  
  - enregistrement dans Intune + Entra ID

---

## 7. Valeur pour le Modern Workplace

Cette brique démontre :

- compréhension du provisioning moderne  
- maîtrise des profils Autopilot  
- maîtrise de l’ESP  
- capacité à auditer via Graph  
- vision bout‑en‑bout du cycle de vie device
Script d’export Autopilot (optionnel mais très valorisant)
Dans scripts/graph/Export-AutopilotDevices.ps1 (si tu veux l’ajouter plus tard) tu pourras mettre un script qui :

se connecte à Graph

appelle /deviceManagement/windowsAutopilotDeviceIdentities

exporte en CSV
