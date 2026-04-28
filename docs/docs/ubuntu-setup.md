Annexe — Installation & Troubleshooting Ubuntu
Objectif
Documenter l’installation, la configuration et le dépannage d’un environnement Ubuntu utilisé comme poste de test dans le cadre du lab Modern Workplace / Zero Trust.

1. Installation Ubuntu Server
Installation d’Ubuntu Server (version LTS)

Configuration réseau

Ajout d’un utilisateur administrateur

Mise à jour du système :

bash
sudo apt update && sudo apt upgrade -y
2. Installation d’une interface graphique (XFCE)
bash
sudo apt install xfce4 xfce4-goodies -y
sudo apt install lightdm -y
sudo dpkg-reconfigure lightdm
3. Installation de Google Chrome
bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb -y
4. Troubleshooting rencontré
Problème : interface graphique ne démarrait pas
Cause : absence de LightDM / conflit avec GDM
Solution :

bash
sudo dpkg-reconfigure lightdm
sudo reboot
Problème : écran noir après login
Cause : XFCE non installé
Solution :

bash
sudo apt install xfce4 -y
Problème : dépendances manquantes pour Chrome
Solution :

bash
sudo apt --fix-broken install -y
5. Conclusion
Cette annexe démontre :

installation complète d’un environnement Linux

résolution de problèmes système

configuration d’une interface graphique

installation d’applications

autonomie en troubleshooting
