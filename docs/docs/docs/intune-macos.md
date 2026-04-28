Intune — Déploiement de scripts Shell (macOS)
Objectif
Documenter la méthode professionnelle pour déployer des scripts Shell sur macOS via Intune, avec exécution root et logs.

1. Préparation du script Shell
Un script macOS doit :

être en bash ou zsh

être exécutable (chmod +x)

ne pas afficher de GUI

écrire des logs dans /tmp ou /var/log

Exemple : inventaire macOS
bash
#!/bin/bash
OUTPUT="/tmp/mac_inventory.json"
# … contenu du script …
echo "Inventaire généré : $OUTPUT"
2. Import du script dans Intune
Intune Admin Center → Devices → macOS → Shell scripts → Add

Paramètres recommandés :

Paramètre	Valeur
Run script as signed-in user	No
Run script as root	Yes
Script frequency	Every 1 hour
Output	Collect script output


3. Logs Intune sur macOS
Les logs Intune sont essentiels pour diagnostiquer les scripts.

Dossiers :
Code
/Library/Logs/Microsoft/Intune
/var/log/intune
Fichiers importants :
IntuneMDMDaemon.log

IntuneMDMAgent.log

shellscript.log (exécution des scripts)

4. Validation de l’exécution
Exemples de fichiers générés :

Code
/tmp/mac_inventory.json
/tmp/mac_compliance.json
5. Troubleshooting
Problème	Cause	Solution
Script non exécuté	Pas root	Activer “Run as root”
Pas de log	Script silencieux	Ajouter echo
Erreur 126	Droits	chmod +x script.sh
Script OK mais pas d’effet	Chemins protégés	Utiliser /tmp


6. Conclusion
Cette section démontre :

la maîtrise du packaging Intune macOS

l’exécution root

la gestion des logs macOS

la capacité à gérer un parc Apple en entreprise

