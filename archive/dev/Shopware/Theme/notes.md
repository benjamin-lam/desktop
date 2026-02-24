🧩 1. Theme-Registrierung & Vererbung

Fallstrick:
Die theme.json ist formal korrekt, aber das Theme wird im Admin nicht erkannt oder nicht korrekt vererbt.

Ursachen & Lösungen:

composer.json fehlt oder ist nicht korrekt verknüpft → Theme wird nicht als Plugin erkannt.
→ Prüfe "type": "shopware-platform-plugin" und "autoload"-Namespace.

theme.json liegt im falschen Ordner oder hat falsche Struktur →
Sie muss im Root des Plugins liegen, nicht in Resources oder src.

"parentTheme": "Storefront" ist falsch oder fehlt → dann fehlen essentielle Twig-Blöcke und CSS-Tokens.


Tipp:
Immer bin/console theme:refresh && bin/console theme:compile ausführen, sonst cached Shopware alte Manifestdaten.


---

🧱 2. Cache & Theme-Kompilation

Fallstrick:
Änderungen an Twig, SCSS oder JS erscheinen nicht im Frontend.

Ursachen & Lösungen:

Shopware cached aggressiv. Nach Änderungen:

bin/console cache:clear
bin/console theme:compile

Wenn SCSS-Dateien nicht neu kompiliert werden, prüfe:

Pfad in theme.json → "style": ["app/storefront/src/scss/base.scss"]

!important: Nur absolute Pfade funktionieren, relative funktionieren nicht zuverlässig bei verschachtelten Plugins.


Wenn du mit DDEV oder Docker arbeitest: Volumes korrekt eingebunden? (node_modules, vendor?)


Tipp:
Im Dev-Modus (APP_ENV=dev) arbeiten – sonst werden Assets im Build-Minify-Modus gecacht.


---

🪞 3. Twig-Override (Template-Vererbung)

Fallstrick:
Twig-Dateien werden nicht überschrieben oder Änderungen greifen nicht.

Ursachen & Lösungen:

Pfadstruktur muss exakt stimmen.
Beispiel: Du willst storefront/layout/header/logo.html.twig überschreiben →
Dein Override muss in
src/Resources/views/storefront/layout/header/logo.html.twig
liegen.

Wichtig: Theme kann nur „unter“ der Storefront überschreiben, nicht über andere Plugins hinweg (außer explizit registriert).

Verwende @Storefront oder @YourThemeName in Twig-Includes korrekt.

Kein extends ohne vollständigen Namespace:

{% sw_extends '@Storefront/storefront/base.html.twig' %}



---

⚙️ 4. SCSS & Asset-Verwaltung

Fallstrick:
Eigene Styles werden nicht geladen oder überdeckt.

Ursachen & Lösungen:

Reihenfolge in theme.json → "style": [...] bestimmt Priorität.
Eigene SCSS-Dateien nach den Storefront-Styles einbinden.

Variablen müssen vor dem Import überschrieben werden:

$sw-color-brand-primary: #123456;
@import "~scss/variables";

(umgekehrt wird der Default-Wert wieder gesetzt)

Assets wie Fonts oder Images müssen über:

@import "~@storefront/assetPath";

referenziert werden – sonst fehlen sie im Build.



---

🧮 5. JS-Handling & Build-Prozess

Fallstrick:
Eigenes JavaScript greift nicht oder wird gar nicht ausgeführt.

Ursachen & Lösungen:

plugin.js ist registriert, aber nicht gebündelt →
theme.json muss "script": ["app/storefront/src/main.js"] enthalten.

main.js muss die Plugin-Klasse registrieren:

import Plugin from 'src/plugin-system/plugin.class';
import PluginManager from 'src/plugin-system/plugin.manager';
class MyPlugin extends Plugin {
  init() {
    console.log('MyPlugin loaded');
  }
}
PluginManager.register('MyPlugin', MyPlugin);

Nach JS-Änderungen: bin/console theme:compile oder bin/build-storefront.sh.



---

🧱 6. CMS Blocks & Layouts

Fallstrick:
Eigenes CMS-Element erscheint im Admin, aber nicht im Frontend (oder gar nicht sichtbar).

Ursachen & Lösungen:

Vue-Komponenten fehlen → index.js in Resources/app/administration richtig registrieren.

Kein plugin.xml oder manifest.xml → Shopware weiß nicht, dass CMS-Komponente existiert.

Cache und bin/console build:administration vergessen.



---

🔒 7. Deployment-Fallen

Fallstrick:
Theme funktioniert in DEV, aber nicht auf PROD.

Ursachen & Lösungen:

Assets nicht mit bin/console assets:install oder theme:compile deployed.

Fehlende NODE_ENV=production-Builds – auf Servern oft kein Node.js vorhanden.

Wenn Deployment über CI/CD → Asset-Builds vorher lokal oder in Pipeline ausführen, da Shopware auf Servern keine Node-Binaries braucht.



---

🧠 Bonus: Typische Dev-Workflow-Fallen

Änderungen direkt im /vendor/shopware/storefront gemacht → beim Update überschrieben.
→ Immer eigenes Theme!

Mehrere Themes aktiv → Kompilation verwechselt Dateien. Nur ein Theme pro Sales Channel aktivieren.

Twig-Blöcke doppelt überschrieben → unklare Vererbung.

Kein Fallback bei Icons/Logos → 404-Fehler bei logo.svg.



---

✅ Empfehlung für stabilen Workflow

1. Eigenes Theme per Plugin-Struktur aufbauen

custom/plugins/MyTheme/
├── composer.json
├── theme.json
├── src/Resources/views/
└── src/Resources/app/storefront/


2. Nach jedem größeren Change:

bin/console plugin:refresh
bin/console theme:refresh
bin/console theme:compile


3. Frontend-Check:
DevTools → Netzwerkanalyse → überprüfe theme-<hash>.css & JS-Dateien.
