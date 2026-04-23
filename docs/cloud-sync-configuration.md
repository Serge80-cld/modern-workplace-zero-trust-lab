FICHE TECHNIQUE — Configuration complète de Microsoft Entra Cloud Sync (fin du projet)
Environnement : Windows Server 2022 (DC01), domaine lab.local, tenant Serge540.onmicrosoft.com  
Objectif : Mettre en place la synchronisation hybride AD → Entra ID via Cloud Sync

1. Préparation du contrôleur de domaine
1.1. Désactivation de IE Enhanced Security Configuration (IE ESC)
Cloud Sync utilise un composant basé sur Internet Explorer pour l’authentification.
Il faut donc désactiver IE ESC :

Ouvrir Server Manager → Local Server

Ligne : Configuration de sécurité renforcée d’Internet Explorer

Mettre :

Administrators → OFF

Users → OFF (optionnel)

2. Installation du Microsoft Entra Provisioning Agent
2.1. Téléchargement
Depuis le portail Entra :

Identity → Hybrid management → Cloud Sync → Agents → Download agent

2.2. Installation
Lancer l’installeur sur DC01.

3. Configuration du Provisioning Agent
L’assistant comporte 5 étapes.

3.1. Connexion à Microsoft Entra ID
Cliquer Authenticate

Se connecter avec le compte administrateur Entra :
SergeNgindu@Serge540.onmicrosoft.com

Valider le MFA

3.2. Création du compte gMSA
L’assistant propose :

 Create gMSA (recommandé)

3.3. Fournir les identifiants AD DS
 Ici, il faut un compte du domaine local, pas un compte Entra.

Saisir :

LAB\Administrateur

Mot de passe Administrateur du domaine

3.4. Connexion à Active Directory
L’agent détecte automatiquement :

Domaine : lab.local

Contrôleur : DC01

3.5. Confirmation
L’écran final affiche :

gMSA créé : lab.local\provAgentgMSA

Compte Entra connecté

Domaine AD validé

Cliquer Confirm

L’agent est maintenant installé et opérationnel.

4. Vérification dans le portail Entra
Aller dans :

Identity → Hybrid management → Cloud Sync → Agents

Vous devez voir :

DC01.lab.local

Statut : Active / Healthy

Version OK

5. Création de la configuration Cloud Sync
5.1. Accéder au module
Cloud Sync → Configurations → + Nouvelle configuration

5.2. Activer la synchronisation des mots de passe
Cocher :

✔️ Activer la synchronisation de hachage du mot de passe

5.3. Sélectionner l’agent
Dans le panneau de droite :

Cliquer sur DC01.lab.local

Le bouton Créer devient actif.

Cliquer Créer.

6. Assistant de configuration Cloud Sync
6.1. Étape 1 — Sélection du domaine
Forest : lab.local

Domain : lab.local

Agent : DC01.lab.local

6.2. Étape 2 — Sélection des OU à synchroniser
Recommandation pour un lab propre :

Créer une OU : CloudSync

Y placer 1–2 comptes de test

Sélectionner uniquement cette OU

6.3. Étape 3 — Groupe cible Entra ID
Deux options :

Option A — Tout le tenant  
Simple, rapide.

Option B — Groupe dédié (recommandé)  
Créer un groupe : CloudSync-Test  
Le sélectionner comme cible.

6.4. Étape 4 — Activation
Cliquer :

 Enable configuration

La synchronisation démarre immédiatement.

7. Vérification de la synchronisation
7.1. Logs de provisioning
Cloud Sync → Configurations → [Votre config] → Provisioning logs

Vous devez voir :

Initial cycle completed

Created user

Updated user

0 erreurs

7.2. Vérification dans Entra ID
Identity → Users

Les comptes AD sélectionnés doivent apparaître.

8. Résumé technique
Composant	État
Agent Cloud Sync	Installé sur DC01
gMSA	provAgentgMSA créé
Domaine AD	lab.local
Tenant Entra	Serge540.onmicrosoft.com
Synchro des mots de passe	Activée
OU synchronisée	CloudSync (recommandé)
Groupe cible	CloudSync-Test (optionnel)

