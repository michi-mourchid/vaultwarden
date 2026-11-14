# Guide de Déploiement Rapide - Vaultwarden

Ce dépôt est préconfiguré pour être déployé en quelques secondes sur n'importe quel serveur équipé de Docker et d'un reverse-proxy Caddy (connecté au réseau Docker `web-network`).

---

## 1. Pré-requis DNS
Assurez-vous que votre sous-domaine (ex: `coffre-fort.kapkali.com`) pointe vers l'adresse IP publique de votre serveur (champ `A`).

---

## 2. Déploiement sur le serveur

### Cas A : Déploiement par défaut (`coffre-fort.kapkali.com`)
Rien à configurer, les valeurs par défaut sont déjà prêtes :

```bash
git clone https://github.com/michi-mourchid/vaultwarden.git coffre-fort
cd coffre-fort
docker compose up -d
```

### Cas B : Déploiement avec un autre domaine / autre serveur
Copiez le modèle d'environnement et ajustez le nom de domaine :

```bash
git clone https://github.com/michi-mourchid/vaultwarden.git coffre-fort
cd coffre-fort
cp .env.example .env
nano .env # Modifiez DOMAIN=https://votre-domaine.com
docker compose up -d
```

---

## 3. Ajout dans Caddy

Dans votre dossier `caddy-proxy/Caddyfile`, ajoutez simplement :

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

## 4. Sécurisation finale (Important)

1. Rendez-vous sur votre domaine (ex: `https://coffre-fort.kapkali.com`).
2. Créez immédiatement votre compte utilisateur administrateur.
3. Retournez sur le serveur dans le dossier `coffre-fort/` et verrouillez les inscriptions :
   - Si vous utilisez un fichier `.env` : changez `SIGNUPS_ALLOWED=false`.
   - Ou lancez : `SIGNUPS_ALLOWED=false docker compose up -d`.
