🛠 Debugging-Template: Shopware Theme / Template greift nicht

1. Kontext

Projekt / Mandant / Sales Channel:

Domain / URL in der Analyse:

Problem sichtbar in (Dev / Staging / Prod):

Erwartetes Verhalten:

Tatsächliches Verhalten:

Priorität (Blocker / Hoch / Mittel / Niedrig):



---

2. Reproduktionsschritte

1. …


2. …


3. …


4. Screenshot / Screencast vorhanden? (ja/nein, Link:)



Letztes funktionierendes Verhalten bekannt seit (Datum / Commit / Release):


---

3. Grundcheck (Bitte abhaken)

[ ] Theme ist im Admin dem richtigen Sales Channel zugewiesen
Admin → Vertriebskanäle → Storefront → Theme

[ ] bin/console theme:compile ohne Fehler durchgelaufen

[ ] bin/console cache:clear ausgeführt

[ ] Browser-Cache geleert / Hard Reload gemacht

[ ] Wir sind wirklich auf dem richtigen System (z. B. nicht Prod-URL auf Staging-DB oder andersrum 😬)



---

4. Twig / Template Overrides

Symptom: Änderungen an .twig greifen nicht.

[ ] Pfad korrekt?
custom/plugins/<ThemeName>/src/Resources/views/...

[ ] sw_extends verwendet?

{% sw_extends '@Storefront/storefront/base.html.twig' %}

[ ] Greift vielleicht ein zweites Plugin und überschreibt denselben Block später?
→ Liste aller Plugins, die dieselbe Datei anfassen:

…


[ ] Test-Output im Template sichtbar? (z. B. <!-- DEBUG THEME XYZ -->)
Ergebnis: …


Fazit Twig-Ebene:

Vermutung:



---

5. CSS / SCSS

Symptom: Styles kommen nicht an oder falsche Farben / Layout.

[ ] Custom-SCSS in theme.json registriert?

"style": [
  "app/storefront/src/scss/base.scss"
]

[ ] Reihenfolge korrekt? Eigene Styles stehen nach den Storefront-Styles.

[ ] Wurde nach SCSS-Änderung kompiliert (theme:compile)?

[ ] Im Frontend DevTools → Network → theme-<hash>.css geladen?

Erwartete Datei:

Tatsächlich geladene Datei:


[ ] In DevTools → Elements → ist die geänderte CSS-Regel wirklich vorhanden?


Fazit CSS-Ebene:

Vermutung:



---

6. JavaScript

Symptom: eigenes Verhalten/Plugin wird nicht ausgeführt.

[ ] Custom-JS in theme.json registriert?

"script": [
  "app/storefront/src/main.js"
]

[ ] Plugin in main.js registriert?

import PluginManager from 'src/plugin-system/plugin.manager';
PluginManager.register('MyPlugin', MyPlugin);
console.log('DEBUG MyPlugin init');

[ ] Steht der console.log im Browser-Console-Output?
Ergebnis:

[ ] JS-Fehler in Console? (Copy hier rein)


Fazit JS-Ebene:

Vermutung:



---

7. Theme-Registrierung / Plugin-Zustand

Symptom: Theme taucht nicht korrekt auf oder reagiert wie ein Fremdkörper.

[ ] Liegt eine gültige composer.json im Theme-Root?

"type": "shopware-platform-plugin"

Autoload korrekt?


[ ] bin/console plugin:refresh ausgeführt?

[ ] Ist das Theme installiert & aktiviert?
bin/console plugin:list | grep <ThemeName>

Status:


[ ] bin/console theme:refresh nach Änderungen an theme.json gelaufen?


Fazit Theme-Setup:

Vermutung:



---

8. Caching / Env / Deployment

Symptom: Lokal geht's, auf Server nicht.

[ ] Welche Umgebung? (APP_ENV=dev / prod)

[ ] Wurde das Deployment inkl. Assets gemacht?

bin/console theme:compile vor Deployment oder auf dem Server ausgeführt?

Node & npm auf Server vorhanden? (falls nein: werden Assets gepackt ausgeliefert?)


[ ] Werden die Assets evtl. von CDN / Reverse Proxy zwischengespeichert?
Details:

[ ] Timestamp der ausgelieferten CSS/JS-Dateien vs. Zeitpunkt der Änderung (Drift?)


Fazit Deployment-Ebene:

Vermutung:



---

9. CMS / Erlebniswelten

Symptom: Custom CMS Block wird im Admin angezeigt, aber im Frontend fehlt Inhalt / falsches Markup.

[ ] Admin gebaut mit aktuellem Build? (bin/console build:administration)

[ ] Wurde das Layout dem richtigen Seiten-Typ zugewiesen (Kategorie / Landingpage / Produktdetail)?

[ ] Twig-Template des CMS-Blocks korrekt im Theme vorhanden?
Pfad geprüft:

[ ] Gibt es Fehler im Symfony-Log (var/log/dev-*.log oder prod-*.log)?


Fazit CMS-Ebene:

Vermutung:



---

10. Logs & Fehlermeldungen

Browser Console Errors (JS):

…


HTTP-Fehler (404/500 in Network Tab):

…


PHP-/Symfony-Logs:

…


Shopware Exception-Log (var/log/...):

…



Auffällige Meldungen / Stacktraces:

...


---

11. Einschätzung / nächste Aktion

Wahrscheinlichste Ursache aktuell:

Risiko (UX kaputt / Checkout betroffen / nur Styling):

Nächster Schritt:

[ ] Template-Fix

[ ] Recompile

[ ] Rollback

[ ] Weiter an Dev geben

[ ] Kunde informieren



Owner:
ETA intern:


---

12. Notizen / Historie

Letzte Theme-Änderung durch:

Datum / Commit / Branch:

Hatten wir so ein Problem schon mal? Link zum Ticket/Wiki:
