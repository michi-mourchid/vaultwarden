# Nomenclature Normée des Logos (Template Multi-Clients)

Pour remplacer les logos officiels par les fichiers de votre client, placez-les dans ce dossier (`custom/branding/`) en respectant strictement cette nomenclature :

| Fichier obligatoire | Format recommandé | Dimensions conseillées | Utilisation |
| :--- | :--- | :--- | :--- |
| **`logo.svg`** | SVG (ou PNG transparent) | ~ 260 x 50 px | Logo principal horizontal (page de connexion, header de navigation, console admin). |
| **`logo-icon.svg`** | SVG (ou PNG transparent) | 64 x 64 px ou 128 x 128 px | Icône carrée (écran de chargement, icône mobile / favicon). |

### Règles de compatibilité :
1. **Format :** Préférez le format vectoriel `.svg` pour une netteté parfaite sur tous les écrans (Retina, 4K). Si vous utilisez un `.png`, conservez impérativement un fond transparent.
2. **Prise en compte immédiate :** Ce dossier est monté en direct dans le conteneur Docker. Le simple remplacement d'un fichier est visible immédiatement après un rafraîchissement complet (`Ctrl + F5`) sans avoir à reconstruire d'image Docker.
