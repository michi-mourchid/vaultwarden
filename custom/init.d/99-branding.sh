#!/bin/sh
# ==============================================================================
# SCRIPT DE DEMARRAGE : INJECTION DU BRANDING CFAM976
# Execute automatiquement par /docker/start.sh au lancement du conteneur
# ==============================================================================

# 1. Copie du script local custom.js vers /web-vault (permettant la conformite CSP 'self')
if [ -f /custom/branding/custom.js ]; then
    cp /custom/branding/custom.js /web-vault/custom.js
fi

# 2. Injection propre du script externe sans inline script (zero impact securite)
if [ -f /web-vault/index.html ]; then
    if ! grep -q "custom.js" /web-vault/index.html; then
        sed -i 's#</head>#<script src="custom.js" defer></script></head>#' /web-vault/index.html
    fi
fi
