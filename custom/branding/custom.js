/**
 * ==============================================================================
 * GESTIONNAIRE DE MOTS DE PASSE - PERSONNALISATION DU TITRE D'ONGLET
 * ==============================================================================
 * Sécurité :
 * - Servi en local depuis 'self' : 100% conforme à la Content-Security-Policy (CSP).
 * - Aucun script inline ou 'unsafe-inline' nécessaire.
 * - Aucune dépendance externe, aucun tracking.
 * - Ne touche pas aux clés de chiffrement ni aux flux d'authentification.
 * ==============================================================================
 */
(function () {
  const APP_NAME_FULL = "Coffre-fort Numérique";
  const BRAND_SHORT = "Coffre-fort";

  function applyCustomTitle() {
    const currentTitle = document.title;
    if (!currentTitle || currentTitle === "Bitwarden Web Vault" || currentTitle === "Bitwarden") {
      document.title = APP_NAME_FULL;
    } else if (currentTitle.includes("Bitwarden")) {
      document.title = currentTitle.replace(/Bitwarden/g, BRAND_SHORT);
    } else if (!currentTitle.includes(BRAND_SHORT)) {
      document.title = `${currentTitle} | ${BRAND_SHORT}`;
    }
  }

  // Application immédiate au chargement initial
  applyCustomTitle();

  // Observer les changements dynamiques de titre effectués par Angular (SPA)
  const titleElement = document.querySelector("title");
  if (titleElement) {
    const observer = new MutationObserver(applyCustomTitle);
    observer.observe(titleElement, {
      subtree: true,
      characterData: true,
      childList: true,
    });
  }
})();
