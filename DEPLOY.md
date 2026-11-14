# Guide de Déploiement & Templatisation - Vaultwarden

Ce dépôt est préconfiguré pour être déployé en quelques secondes sur n'importe quel serveur équipé de Docker et d'un reverse-proxy Caddy (connecté au réseau Docker `web-network`).

---

## 1. Pré-requis DNS
Assurez-vous que votre sous-domaine (ex: `coffre-fort.kapkali.com`) pointe vers l'adresse IP publique de votre serveur (champ `A`).

---

## 2. Déploiement sur le serveur

### Déploiement par défaut (CFAM976)
Rien à configurer, les valeurs de domaine, le thème CFAM976 et le titre dynamique sont déjà prêts :

```bash
git clone https://github.com/michi-mourchid/vaultwarden.git coffre-fort
cd coffre-fort
docker compose up -d
```

---

## 3. Templatisation (Nouveau Projet / Autre Client)

Pour adapter ce projet à **n'importe quel autre nom de domaine, marque ou palette de couleurs**, vous n'avez **aucun code ni aucun fichier SCSS à modifier** !

Copiez simplement `.env.example` en `.env` :
```bash
cp .env.example .env
nano .env
```

Vous pouvez y modifier :
```env
# Domaine
DOMAIN=https://mon-autre-domaine.com

# Titre et Marque
APP_NAME=Coffre-fort MDP | MonProjet
BRAND_SHORT=MonProjet

# Palette de couleurs personnalisée
COLOR_PRIMARY=#007BFF
COLOR_PRIMARY_HOVER=#0056B3
COLOR_HEADER=#1A202C
COLOR_DARK=#111827
COLOR_LIGHT=#F3F4F6
COLOR_WHITE=#FFFFFF
```

Puis lancez :
```bash
docker compose up -d
```
Le conteneur compile automatiquement votre thème et applique le titre au démarrage !

---

## 4. Ajout dans Caddy

Dans votre dossier `caddy-proxy/Caddyfile`, ajoutez :

```caddy
coffre-fort.kapkali.com {
    import security_headers
    encode gzip zstd

    reverse_proxy vaultwarden:80
}
```

Puis rechargez Caddy sans coupure :
```bash
docker exec global-proxy caddy reload --config /etc/caddy/Caddyfile
```

---

## 5. Personnalisation des Logos (Nomenclature Normée)

Pour remplacer les logos, déposez-les simplement dans le dossier `custom/branding/` :

| Nom de fichier | Format | Dimensions idéales | Rôle |
| :--- | :--- | :--- | :--- |
| **`logo.svg`** | SVG / PNG | ~ 260 x 50 px | Logo principal (page de connexion, barre de navigation, console admin) |
| **`logo-icon.svg`** | SVG / PNG | 64 x 64 px | Icône carrée (splash screen de chargement et icône mobile) |

Rafraîchissez votre navigateur (`Ctrl + F5`), les modifications sont immédiates !

---

## 6. Sécurisation finale (Post-déploiement)

1. Rendez-vous sur votre domaine (ex: `https://coffre-fort.kapkali.com`).
2. Créez immédiatement votre compte utilisateur administrateur.
3. Sur le serveur, verrouillez les inscriptions pour que personne d'autre ne puisse créer de compte :
   ```bash
   cd ~/coffre-fort
   SIGNUPS_ALLOWED=false docker compose up -d
   ```
