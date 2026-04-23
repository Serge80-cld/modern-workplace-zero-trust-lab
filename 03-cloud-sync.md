Objectif
Mettre en place une synchronisation hybride moderne entre Active Directory On‑Prem et Entra ID via Cloud Sync, la version légère et moderne d’Azure AD Connect.
1. Architecture du Lab
On‑Prem
1 VM Windows Server (DC)

Domaine : sergelab.local

OU dédiée : OU=CloudSync

Utilisateurs + groupes à synchroniser

Cloud
Tenant Entra ID

Cloud Sync activé

Agent Cloud Sync installé sur le DC

 2. Concepts clés
Azure AD Connect (ancien modèle)
Agent lourd

SQL Server requis

Sync toutes les 30 min

Complexe à maintenir

Entra Connect Cloud Sync (moderne)
Agent léger

Sync toutes les 2 minutes

Multi‑forêts

Haute disponibilité simple

Recommandé par Microsoft

 C’est la technologie moderne que les entreprises adoptent.

 3. Préparation de l’Active Directory
 Créer une OU dédiée
Code
OU=CloudSync,DC=sergelab,DC=local
 Créer 3 utilisateurs
alice.cloud

bob.cloud

charlie.cloud

 Créer un groupe
CloudSync-Users

 4. Activer Cloud Sync dans Entra
Dans https://entra.microsoft.com :

Identity → Hybrid management

Cloud Sync

New configuration

Choisir :

Forest : sergelab.local

Sync type : Cloud Sync

Scope : **OU=CloudSync`

Télécharger l’agent.

 5. Installer l’agent Cloud Sync
Sur ton DC :

Lancer le MSI téléchargé

Se connecter avec ton compte admin Entra

L’agent s’enregistre automatiquement

Vérifier dans Entra :

Agent status : Healthy

Last sync : quelques secondes

 6. Vérifier la synchronisation
Dans Entra → Users :

Chercher :

alice.cloud

bob.cloud

charlie.cloud

Ils doivent apparaître avec :

Source : Windows Server AD

Provisioning : Cloud Sync

 7. Tester une modification
Sur ton DC :

Modifier le prénom de alice.cloud

Attendre 2 minutes

Vérifier dans Entra

 Cloud Sync est beaucoup plus rapide qu’Azure AD Connect.

 8. Bonus : Password Writeback + SSPR
Activer dans Entra :

Self-Service Password Reset

Password Writeback

Résultat :

L’utilisateur change son mot de passe dans le cloud

Le mot de passe est répliqué vers l’AD On‑Prem

 9. Troubleshooting
 Vérifier l’agent
Code
Get-Service -Name "Microsoft Entra Connect Provisioning Agent"
 Redémarrer l’agent
Code
Restart-Service -Name "Microsoft Entra Connect Provisioning Agent"
Quand tu as collé ce contenu dans ton fichier, dis-moi “c’est fait”, et on passe à l’étape suivante :

 Étape 2 : Ajouter le script PowerShell dans /scripts/cloud-sync/prepare-ad.ps1
 Étape 3 : Ajouter le diagramme d’architecture dans ton README
## 🔷 10. Architecture Cloud Sync (diagramme)

Voici une représentation simple de l’architecture mise en place :

                 +----------------------------+
                 |      Active Directory      |
                 |      sergelab.local        |
                 |                            |
                 |  - OU=CloudSync            |
                 |  - Utilisateurs            |
                 |  - Groupes                 |
                 +--------------+-------------+
                                |
                                | Cloud Sync Agent
                                | (installé sur le DC)
                                |
                 +--------------v-------------+
                 |        Entra ID            |
                 |        (Cloud)             |
                 |                            |
                 |  - Cloud Sync Config       |
                 |  - Utilisateurs synchronisés|
                 |  - Groupes synchronisés    |
                 +----------------------------+
