# Nomenclature Normée des Logos (Templatisation CFAM976)

Pour remplacer les logos officiels par vos propres fichiers, placez-les dans ce dossier (`custom/branding/`) en respectant strictement cette nomenclature :

| Fichier | Format | Dimensions conseillées | Utilisation |
| :--- | :--- | :--- | :--- |
| **`logo.svg`** | SVG (ou PNG) | ~ 260 x 50 px | Logo principal horizontal (page de connexion, header de navigation, console admin). |
| **`logo-icon.svg`** | SVG (ou PNG) | 64 x 64 px ou 128 x 128 px | Icône carrée (écran de chargement, icône mobile / favicon). |

### Règles de compatibilité :
1. **Format :** Préférez le format vectoriel `.svg` pour une netteté parfaite sur tous les écrans (Retina, 4K). Si vous utilisez un `.png`, conservez un fond transparent.
2. **Pas besoin de reconstruire :** Le dossier est monté en direct dans le conteneur Docker. Toute mise à jour de ces fichiers est prise en compte après un simple rafraîchissement du navigateur (`Ctrl + F5`).
