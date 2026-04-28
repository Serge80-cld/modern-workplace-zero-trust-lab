Dashboard Power BI — Inventaire & Conformité Intune
Objectif
Créer un dashboard Power BI professionnel basé sur les données Intune / Graph afin de visualiser :

l’inventaire des devices

la conformité

les OS

les KPIs de gestion
1. Export des données Intune / Graph
1.1 Inventaire des devices (Graph API)
Endpoint :
GET https://graph.microsoft.com/beta/deviceManagement/managedDevices
Exporter les champs utiles :

deviceName

operatingSystem

osVersion

complianceState

lastSyncDateTime

manufacturer

model
1.2 Conformité
Endpoint :
GET https://graph.microsoft.com/beta/deviceManagement/managedDevices?$select=deviceName,complianceState
1.3 OS Versions
Créer un CSV simple :
| os | version | count |
| --- | --- | --- |
2. Structure des fichiers CSV
Dans powerbi/data/, tu auras :

✔️ devices.csv
| deviceName | operatingSystem | osVersion | manufacturer | model | lastSyncDateTime |

✔️ compliance.csv
| deviceName | complianceState |

✔️ os_versions.csv
| os | version | count |
3. Import dans Power BI
Ouvrir Power BI Desktop

Get Data → Text/CSV

Importer :

devices.csv

compliance.csv

os_versions.csv

Aller dans Model view

Créer les relations :
devices.deviceName 1—* compliance.deviceName
. Pages du Dashboard
🟦 Page 1 — Inventaire
Visuels recommandés :

Tableau : deviceName, OS, version

Bar chart : devices par OS

Pie chart : devices par fabricant

Card : nombre total de devices

🟦 Page 2 — Conformité
Visuels :

Donut : % compliant / non compliant

Table : deviceName + complianceState

Bar chart : non compliant par OS

🟦 Page 3 — Vue Management (KPIs)
Visuels :

Card : % conformité

Card : nombre de devices non conformes

Card : OS le plus utilisé

Line chart : évolution de la conformité (si tu ajoutes un champ date)

5. Mesures DAX utiles
✔️ % conformité
DAX
ComplianceRate = 
DIVIDE(
    COUNTROWS(FILTER(compliance, compliance[complianceState] = "compliant")),
    COUNTROWS(compliance)
)
✔️ Nombre de devices non conformes
DAX
NonCompliantCount =
COUNTROWS(FILTER(compliance, compliance[complianceState] <> "compliant"))
6. Publication dans ton repo GitHub
Enregistrer ton fichier Power BI sous :

Code
powerbi/dashboard/modern-workplace-dashboard.pbix
Commit :
“Add Power BI dashboard (inventory & compliance)”

7. Intégration dans ton portfolio GitHub
Dans ton README principal, ajoute :

Code
### Dashboard Power BI — Inventaire & Conformité
Un dashboard Power BI professionnel basé sur les données Intune / Graph.
- Inventaire complet
- Conformité
- KPIs management
- OS breakdown

[Voir le fichier .pbix](powerbi/dashboard/modern-workplace-dashboard.pbix)
