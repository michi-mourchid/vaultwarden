#!/bin/sh
# ==============================================================================
# SCRIPT DE DEMARRAGE : TEMPLATISATION DYNAMIQUE (TITRE, COULEURS & LOGOS)
# Execute automatiquement par /docker/start.sh au lancement du conteneur
# ==============================================================================

# 1. Variables par defaut (Charte CFAM976) si non specifiees dans l'environnement
APP_NAME="${APP_NAME:-Gestionnaire MDP | CFAM976}"
BRAND_SHORT="${BRAND_SHORT:-CFAM976}"

COLOR_PRIMARY="${COLOR_PRIMARY:-#FF7F00}"
COLOR_PRIMARY_HOVER="${COLOR_PRIMARY_HOVER:-#E06F00}"
COLOR_HEADER="${COLOR_HEADER:-#110979}"
COLOR_DARK="${COLOR_DARK:-#0B0654}"
COLOR_LIGHT="${COLOR_LIGHT:-#F4F4F5}"
COLOR_WHITE="${COLOR_WHITE:-#FFFFFF}"

# 2. Generation dynamique du SCSS dans /app/templates (lu par Vaultwarden)
mkdir -p /app/templates/scss
if [ -f /custom/templates/scss/user.vaultwarden.scss.template ]; then
    sed \
        -e "s|__COLOR_PRIMARY__|${COLOR_PRIMARY}|g" \
        -e "s|__COLOR_PRIMARY_HOVER__|${COLOR_PRIMARY_HOVER}|g" \
        -e "s|__COLOR_HEADER__|${COLOR_HEADER}|g" \
        -e "s|__COLOR_DARK__|${COLOR_DARK}|g" \
        -e "s|__COLOR_LIGHT__|${COLOR_LIGHT}|g" \
        -e "s|__COLOR_WHITE__|${COLOR_WHITE}|g" \
        /custom/templates/scss/user.vaultwarden.scss.template > /app/templates/scss/user.vaultwarden.scss.hbs
fi

# 3. Generation dynamique du script custom.js avec le titre et le nom de marque
if [ -f /custom/branding/custom.js.template ]; then
    sed \
        -e "s|__APP_NAME__|${APP_NAME}|g" \
        -e "s|__BRAND_SHORT__|${BRAND_SHORT}|g" \
        /custom/branding/custom.js.template > /web-vault/custom.js
elif [ -f /custom/branding/custom.js ]; then
    cp /custom/branding/custom.js /web-vault/custom.js
fi

# 4. Injection securisee du script dans /web-vault/index.html (conforme CSP 'self')
if [ -f /web-vault/index.html ]; then
    if ! grep -q "custom.js" /web-vault/index.html; then
        sed -i 's#</head>#<script src="custom.js" defer></script></head>#' /web-vault/index.html
    fi
fi
