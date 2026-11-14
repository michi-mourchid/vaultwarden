# Guide de Déploiement & Personnalisation - CFAM976

Ce dépôt est préconfiguré pour être déployé en quelques secondes sur n'importe quel serveur équipé de Docker et d'un reverse-proxy Caddy (connecté au réseau Docker `web-network`).

---

## 1. Pré-requis DNS
Assurez-vous que votre sous-domaine (ex: `coffre-fort.kapkali.com`) pointe vers l'adresse IP publique de votre serveur (champ `A`).

---

## 2. Déploiement sur le serveur

### Déploiement automatique
Rien à configurer, les valeurs de domaine, le thème CFAM976 et le titre dynamique sont déjà prêts :

```bash
git clone https://github.com/michi-mourchid/vaultwarden.git coffre-fort
cd coffre-fort
docker compose up -d
```

*(Si vous déployez sur un autre domaine, ajoutez simplement un fichier `.env` avec `DOMAIN=https://mon-autre-domaine.com`).*

---

## 3. Ajout dans Caddy

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

## 4. Personnalisation des Logos (Nomenclature Normée)

Pour remplacer les logos par vos propres fichiers officiels, déposez-les dans le dossier `custom/branding/` :

| Nom de fichier | Format | Dimensions idéales | Rôle |
| :--- | :--- | :--- | :--- |
| **`logo.svg`** | SVG / PNG | ~ 260 x 50 px | Logo principal (page de connexion, barre de navigation, console admin) |
| **`logo-icon.svg`** | SVG / PNG | 64 x 64 px | Icône carrée (splash screen de chargement et icône mobile) |

Une fois les fichiers déposés, rafraîchissez simplement votre navigateur (`Ctrl + F5`), les modifications sont immédiates !

---

## 5. Sécurisation finale (Post-déploiement)

1. Rendez-vous sur votre domaine (ex: `https://coffre-fort.kapkali.com`).
2. Créez immédiatement votre compte utilisateur administrateur.
3. Sur le serveur, verrouillez les inscriptions pour que personne d'autre ne puisse créer de compte :
   ```bash
   cd ~/coffre-fort
   SIGNUPS_ALLOWED=false docker compose up -d
   ```
