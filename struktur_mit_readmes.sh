#!/bin/bash
# Skript zum Erstellen der Ordnerstruktur und Generieren von README.md für jeden Ordner
# sowie einer zentralen llms.md für LLM-Agenten.

set -e  # Skript abbrechen, wenn ein Befehl fehlschlägt

# ============================================
# Konfiguration
# ============================================
BASE_DIR="./volumes/repo/"

# ============================================
# Funktionen zur Rückgabe des README-Inhalts
# ============================================
generate_readme_content() {
    local folder="$1"
    case "$folder" in
        "00_Projektbasis")
            cat <<EOF
# 00_Projektbasis

Dieser Bereich enthält alle übergeordneten Dokumente, die den Projektrahmen definieren: Briefings, Angebote, Zeitpläne und rechtliche Grundlagen. Hier wird der Grundstein für jedes Projekt gelegt.

**Beispiele:**
- Projektmanagement-Handbuch
- Vorlagen für Projektanträge
- Übersicht aller Kundenprojekte

**Nicht hierher gehören:**
- Fachliche Konzepte → in \`01_Konzeption_und_Strategie\`
- Umsetzungsdetails → in \`02_Umsetzung_und_Entwicklung\`
EOF
            ;;
        "00_Projektbasis/01_Briefing_und_Scoping")
            cat <<EOF
# 01_Briefing_und_Scoping

Hier werden alle Dokumente rund um das Briefing, die Anforderungsanalyse und das Projekt-Scoping abgelegt. Dazu gehören Kundenbefragungen, Lastenhefte, Pflichtenhefte, erste Skizzen, etc.

**Beispiele:**
- Briefingprotokoll.pdf
- Fragenkatalog.md
- Projektsteckbrief.docx
- Anforderungsliste.xlsx
- User Stories.md

**Nicht hierher gehören:**
- Konkrete Designentwürfe → in \`01_Konzeption_und_Strategie/04_Design_und_UX_Strategie\`
- Kostenkalkulationen → in \`00_Projektbasis/02_Angebot_und_Kalkulation\`
- Technische Architektur → in \`01_Konzeption_und_Strategie/06_Technische_Konzeption\`
EOF
            ;;
        "00_Projektbasis/02_Angebot_und_Kalkulation")
            cat <<EOF
# 02_Angebot_und_Kalkulation

In diesem Ordner landen alle kaufmännischen Dokumente: Angebote, Kostenvoranschläge, Verträge, Rechnungen und Kalkulationsmodelle.

**Beispiele:**
- Angebot_Musterfirma_2026.docx
- Kalkulation_Webprojekt.xlsx
- Vertrag_Entwicklungsleistung.pdf
- Stundennachweise

**Nicht hierher gehören:**
- Projektplanung → in \`00_Projektbasis/03_Projektphasen_und_Meilensteine\`
- Rechtliche Dokumente (AGB, Datenschutz) → in \`00_Projektbasis/04_Recht_und_Datenschutz\`
- Technische Spezifikationen → in \`01_Konzeption_und_Strategie\`
EOF
            ;;
        "00_Projektbasis/03_Projektphasen_und_Meilensteine")
            cat <<EOF
# 03_Projektphasen_und_Meilensteine

Alle Dokumente zur Projektplanung: Zeitpläne, Meilensteine, Ressourcenplanung, Projektstrukturpläne und Statusberichte.

**Beispiele:**
- Projektplan_Gantt.xlsx
- Meilensteintrendanalyse.pdf
- Kapazitätsplanung.ods
- Wochenberichte.md

**Nicht hierher gehören:**
- Briefing und Anforderungen → in \`00_Projektbasis/01_Briefing_und_Scoping\`
- Detaillierte Konzepte → in \`01_Konzeption_und_Strategie\`
- Abrechnungsdaten → in \`00_Projektbasis/02_Angebot_und_Kalkulation\`
EOF
            ;;
        "00_Projektbasis/04_Recht_und_Datenschutz")
            cat <<EOF
# 04_Recht_und_Datenschutz

Hier werden alle rechtlich relevanten Dokumente gesammelt: AGB, Datenschutzerklärungen, Einwilligungserklärungen (DSGVO), Verträge mit Drittanbietern, Impressumsvorlagen, sowie Hinweise zur EU-KI-Verordnung.

**Beispiele:**
- AGB_Muster.docx
- Datenschutzerklärung_Website.md
- Einwilligung_Newsletter.pdf
- KI-Verordnung_Checkliste.md

**Nicht hierher gehören:**
- Projektverträge mit Kunden → in \`00_Projektbasis/02_Angebot_und_Kalkulation\`
- Technische Sicherheitskonzepte → in \`02_Umsetzung_und_Entwicklung/05_Backend_Entwicklung_und_Integration\`
- Ethikrichtlinien für Projekte → ggf. in \`01_Konzeption_und_Strategie\` (als Teil der Strategie)
EOF
            ;;
        "01_Konzeption_und_Strategie")
            cat <<EOF
# 01_Konzeption_und_Strategie

Dieser Bereich bündelt alle strategischen und konzeptionellen Arbeiten. Von der ersten Idee bis zum fertigen Konzept für Design, Content und Technik.

**Beispiele:**
- Prozessbeschreibungen
- Methodenhandbuch
- Qualitätsstandards

**Nicht hierher gehören:**
- Operative Umsetzungsdokumente → in \`02_Umsetzung_und_Entwicklung\`
- Betriebsdokumente → in \`03_Betrieb_und_Optimierung\`
EOF
            ;;
        "01_Konzeption_und_Strategie/01_Recherche_und_Analyse")
            cat <<EOF
# 01_Recherche_und_Analyse

Dokumentation der Markt-, Wettbewerbs- und Zielgruppenanalyse. Hier liegen Personas, Wettbewerbsmatrix, SWOT-Analysen, Umfrageergebnisse und Datenauswertungen.

**Beispiele:**
- Wettbewerbsanalyse.xlsx
- Personas.md
- Marktforschungsbericht.pdf
- Umfrageauswertung_2026.pdf

**Nicht hierher gehören:**
- Briefingunterlagen → in \`00_Projektbasis/01_Briefing_und_Scoping\`
- Eigentliche Konzeptdokumente → in den Unterordnern von \`01_Konzeption_und_Strategie\`
- SEO-Analysen → in \`03_Betrieb_und_Optimierung/05_SEO_und_Suchmaschinenoptimierung\` (wenn fortlaufend)
EOF
            ;;
        "01_Konzeption_und_Strategie/02_Grobkonzept")
            cat <<EOF
# 02_Grobkonzept

Hier entstehen die ersten groben Entwürfe: Strukturskizzen, Wireframes (Low-Fidelity), Site-Maps, Ablaufdiagramme und erste Inhaltsstrukturen.

**Beispiele:**
- Sitemap.pdf
- Wireframes_Handskizzen.jpg
- Inhaltsstruktur.md
- User_Flow.pptx

**Nicht hierher gehören:**
- Ausformulierte Designs → in \`01_Konzeption_und_Strategie/04_Design_und_UX_Strategie\`
- Detaillierte technische Pläne → in \`01_Konzeption_und_Strategie/06_Technische_Konzeption\`
- Ausformulierte Texte → in \`02_Umsetzung_und_Entwicklung/02_Textproduktion\`
EOF
            ;;
        "01_Konzeption_und_Strategie/03_Feinkonzept")
            cat <<EOF
# 03_Feinkonzept

Detaillierte Ausarbeitung des Konzepts: Seitenbeschreibungen, Interaktionsdesign, Navigationskonzepte, Anforderungen an Funktionalitäten.

**Beispiele:**
- Seitenbeschreibungen.md
- Interaktionskonzept.pdf
- Funktionale_Anforderungen.xlsx
- Anwendungsfälle.md

**Nicht hierher gehören:**
- Visuelle Gestaltung → in \`01_Konzeption_und_Strategie/04_Design_und_UX_Strategie\`
- Textinhalte → in \`02_Umsetzung_und_Entwicklung/02_Textproduktion\`
- Programmcode → in \`02_Umsetzung_und_Entwicklung/04_Frontend_Entwicklung\` oder \`05_Backend_Entwicklung\`
EOF
            ;;
        "01_Konzeption_und_Strategie/04_Design_und_UX_Strategie")
            cat <<EOF
# 04_Design_und_UX_Strategie

Alle Dokumente zur visuellen Gestaltung und User Experience: Styleguides, Designsysteme, Moodboards, High-Fidelity-Wireframes, Prototypen (z.B. in Figma), Barrierefreiheitskonzepte.

**Beispiele:**
- Designsystem.md (Farben, Typografie)
- Figma_Prototyp_Links.md
- Barrierefreiheit_Checkliste.pdf
- UI_Komponentenbibliothek

**Nicht hierher gehören:**
- Technische Umsetzungsdetails → in \`02_Umsetzung_und_Entwicklung/04_Frontend_Entwicklung\`
- Konzeptionelle Skizzen (Low-Fi) → in \`01_Konzeption_und_Strategie/02_Grobkonzept\`
- Usability-Test-Ergebnisse → in \`02_Umsetzung_und_Entwicklung/01_UX_Usability_Tests\`
EOF
            ;;
        "01_Konzeption_und_Strategie/05_Content_Strategie")
            cat <<EOF
# 05_Content_Strategie

Hier werden alle strategischen Überlegungen zu Inhalten festgehalten: Content-Konzept, Tonalität, Redaktionsplan, SEO-Strategie (inhaltsbezogen), KI-Textgenerierungs-Prompts.

**Beispiele:**
- Redaktionsplan.xlsx
- Tonalität_und_Sprache.md
- Keyword_Recherche.xlsx
- Prompt_Library_Textgenerierung.md

**Nicht hierher gehören:**
- Fertig produzierte Texte → in \`02_Umsetzung_und_Entwicklung/02_Textproduktion\`
- Technische SEO-Aspekte → in \`03_Betrieb_und_Optimierung/05_SEO_und_Suchmaschinenoptimierung\`
- Design-Richtlinien → in \`01_Konzeption_und_Strategie/04_Design_und_UX_Strategie\`
EOF
            ;;
        "01_Konzeption_und_Strategie/06_Technische_Konzeption")
            cat <<EOF
# 06_Technische_Konzeption

Technische Entwürfe: Systemarchitektur, Datenbankmodell, API-Spezifikationen, Auswahl der Technologiestack, Infrastrukturplanung, Security-Konzepte.

**Beispiele:**
- Architekturdiagramm.drawio
- Datenbankschema.sql
- API_Dokumentation.yaml
- Technologiestack_Entscheidung.md
- Security_Konzept.pdf

**Nicht hierher gehören:**
- Tatsächlicher Code → in \`02_Umsetzung_und_Entwicklung/04_Frontend_Entwicklung\` und \`05_Backend_Entwicklung\`
- Deployment-Pläne → in \`03_Betrieb_und_Optimierung/01_Launch_und_Go-Live\`
- Lastenhefte → in \`00_Projektbasis/01_Briefing_und_Scoping\`
EOF
            ;;
        "02_Umsetzung_und_Entwicklung")
            cat <<EOF
# 02_Umsetzung_und_Entwicklung

Alle Dokumente und Dateien, die während der aktiven Umsetzung entstehen: Quellcode, Grafiken, Texte, Testergebnisse.

**Beispiele:**
- Entwicklerhandbuch
- Coding-Guidelines
- Asset-Verwaltung

**Nicht hierher gehören:**
- Strategische Konzepte → in \`01_Konzeption_und_Strategie\`
- Betriebsdokumente → in \`03_Betrieb_und_Optimierung\`
EOF
            ;;
        "02_Umsetzung_und_Entwicklung/01_UX_Usability_Tests")
            cat <<EOF
# 01_UX_Usability_Tests

Ergebnisse von Usability-Tests, Testprotokolle, aufgezeichnete Sessions, Auswertungen und Ableitungen für Verbesserungen.

**Beispiele:**
- Testplan_Usability.md
- Testprotokolle_Runde1.pdf
- Heatmaps_Screenshots
- Auswertung_Handlungsempfehlungen.xlsx

**Nicht hierher gehören:**
- Konzeptionelle Wireframes → in \`01_Konzeption_und_Strategie/02_Grobkonzept\`
- Designsystem → in \`01_Konzeption_und_Strategie/04_Design_und_UX_Strategie\`
- Automatisierte Tests (Code) → in \`02_Umsetzung_und_Entwicklung/06_Testing_und_Qualitaetssicherung\`
EOF
            ;;
        "02_Umsetzung_und_Entwicklung/02_Textproduktion")
            cat <<EOF
# 02_Textproduktion

Alle fertig produzierten Texte: Webseitentexte, Blogartikel, Newsletter, Pressemitteilungen, Produktbeschreibungen. Auch KI-generierte Texte mit den verwendeten Prompts.

**Beispiele:**
- Startseitentext_final.md
- Blogartikel_KI_Trends_2026.docx
- Newsletter_Maerz_2026.html
- Produktbeschreibungen.xlsx
- Prompt_Archiv_Textgenerierung.md

**Nicht hierher gehören:**
- Content-Strategie → in \`01_Konzeption_und_Strategie/05_Content_Strategie\`
- Grafiken → in \`02_Umsetzung_und_Entwicklung/03_Grafik_und_Medienproduktion\`
- Code-Snippets für die Einbindung → in \`02_Umsetzung_und_Entwicklung/04_Frontend_Entwicklung\`
EOF
            ;;
        "02_Umsetzung_und_Entwicklung/03_Grafik_und_Medienproduktion")
            cat <<EOF
# 03_Grafik_und_Medienproduktion

Alle visuellen Assets: Logos, Bilder, Icons, Videos, Animationen, Infografiken, sowie die dazugehörigen Quellformate (z.B. PSD, AI, INDD).

**Beispiele:**
- Logo_Endversion.svg
- Headerbild_Startseite.jpg
- Erklärvideo_Final.mp4
- Icon_Set_AI.eps
- Canva_Vorlagen

**Nicht hierher gehören:**
- UI-Designs (Figma) → in \`01_Konzeption_und_Strategie/04_Design_und_UX_Strategie\`
- Screenshots für Dokumentationen → in den jeweiligen Konzeptordnern
- Code für Bildoptimierung → in \`02_Umsetzung_und_Entwicklung/04_Frontend_Entwicklung\`
EOF
            ;;
        "02_Umsetzung_und_Entwicklung/04_Frontend_Entwicklung")
            cat <<EOF
# 04_Frontend_Entwicklung

Quellcode und zugehörige Dateien für die Umsetzung der Benutzeroberfläche: HTML, CSS, JavaScript, Frontend-Frameworks (React, Vue etc.), Komponenten-Bibliotheken.

**Beispiele:**
- index.html
- style.css
- main.js
- react_components/
- package.json

**Nicht hierher gehören:**
- Backend-Code → in \`02_Umsetzung_und_Entwicklung/05_Backend_Entwicklung_und_Integration\`
- Design-Files → in \`01_Konzeption_und_Strategie/04_Design_und_UX_Strategie\`
- Serverkonfigurationen → in \`03_Betrieb_und_Optimierung/01_Launch_und_Go-Live\` oder \`06_Wartung_und_Support\`
EOF
            ;;
        "02_Umsetzung_und_Entwicklung/05_Backend_Entwicklung_und_Integration")
            cat <<EOF
# 05_Backend_Entwicklung_und_Integration

Serverseitiger Code, Datenbanken, APIs, Schnittstellen zu Drittsystemen, Serverless-Funktionen, Authentifizierung, Zahlungsintegration.

**Beispiele:**
- api_server.py
- database_schema.sql
- integration_stripe.js
- Dockerfile
- cloud_functions/

**Nicht hierher gehören:**
- Frontend-Code → in \`02_Umsetzung_und_Entwicklung/04_Frontend_Entwicklung\`
- API-Spezifikationen (Konzept) → in \`01_Konzeption_und_Strategie/06_Technische_Konzeption\`
- Live-Betriebsdaten → in \`03_Betrieb_und_Optimierung/03_Analytics_und_Data_Insights\`
EOF
            ;;
        "02_Umsetzung_und_Entwicklung/06_Testing_und_Qualitaetssicherung")
            cat <<EOF
# 06_Testing_und_Qualitaetssicherung

Testfälle, Testskripte, automatisierte Tests, Bug-Reports, Qualitätsberichte, Ergebnisse von Code-Reviews, Barrierefreiheitstests.

**Beispiele:**
- Testfaelle_ModulA.xlsx
- unit_tests.py
- Bugtracking_Export.csv
- Code_Review_Checkliste.md
- a11y_test_protokoll.pdf

**Nicht hierher gehören:**
- Usability-Tests (Nutzer) → in \`02_Umsetzung_und_Entwicklung/01_UX_Usability_Tests\`
- Manuelle Testprotokolle aus der Konzeptionsphase → in \`01_Konzeption_und_Strategie\`
- Monitoring-Daten aus dem Betrieb → in \`03_Betrieb_und_Optimierung/03_Analytics\`
EOF
            ;;
        "03_Betrieb_und_Optimierung")
            cat <<EOF
# 03_Betrieb_und_Optimierung

Dokumente und Aufzeichnungen, die nach dem Launch anfallen: Marketingaktivitäten, Analysen, Wartungsprotokolle, kontinuierliche Verbesserungen.

**Beispiele:**
- Betriebshandbuch
- Wartungsprotokolle
- Marketing-Kalender

**Nicht hierher gehören:**
- Umsetzungsdokumente → in \`02_Umsetzung_und_Entwicklung\`
- Konzeptionelle Vorarbeit → in \`01_Konzeption_und_Strategie\`
EOF
            ;;
        "03_Betrieb_und_Optimierung/01_Launch_und_Go-Live")
            cat <<EOF
# 01_Launch_und_Go-Live

Alle Dokumente rund um den Produktivstart: Launch-Checklisten, Deployment-Pläne, Rollback-Strategien, Go-Live-Protokolle, Kommunikationspläne für den Launch.

**Beispiele:**
- Launch_Checkliste.md
- Deployment_Plan.pdf
- Rollback_Szenarien.md
- Go-Live_Protokoll.txt
- Presseverteiler_Launch.csv

**Nicht hierher gehören:**
- Laufende Marketingaktivitäten → in \`03_Betrieb_und_Optimierung/02_Marketing_und_Redaktion\`
- Technische Wartung → in \`03_Betrieb_und_Optimierung/06_Wartung_und_Support\`
- Konzeptionelle Vorbereitung → in \`01_Konzeption_und_Strategie\`
EOF
            ;;
        "03_Betrieb_und_Optimierung/02_Marketing_und_Redaktion")
            cat <<EOF
# 02_Marketing_und_Redaktion

Laufende Marketing- und Redaktionsaktivitäten: Redaktionspläne (operativ), Newsletter-Kampagnen, Social-Media-Posts, Werbeanzeigen, Pressemitteilungen.

**Beispiele:**
- Redaktionsplan_2026_Q2.xlsx
- Newsletter_Kampagne_Juni.html
- Social_Media_Content_Kalender.csv
- Ads_Textentwuerfe.docx
- Pressemitteilung_Neue_Features.pdf

**Nicht hierher gehören:**
- Strategische Content-Planung → in \`01_Konzeption_und_Strategie/05_Content_Strategie\`
- Technische SEO-Maßnahmen → in \`03_Betrieb_und_Optimierung/05_SEO\`
- Auswertungen → in \`03_Betrieb_und_Optimierung/03_Analytics\`
EOF
            ;;
        "03_Betrieb_und_Optimierung/03_Analytics_und_Data_Insights")
            cat <<EOF
# 03_Analytics_und_Data_Insights

Sammlung und Auswertung von Nutzungsdaten: Dashboards, monatliche Reportings, Conversion-Analysen, A/B-Test-Ergebnisse, Heatmaps (laufend), Datenexporte.

**Beispiele:**
- Monatsreport_Maerz_2026.pdf
- Google_Analytics_Dashboard_Links.md
- A_B_Test_Ergebnisse.xlsx
- Heatmaps_Session_Recordings/
- Kundenfeedback_Auswertung.csv

**Nicht hierher gehören:**
- Einmalige Marktforschung → in \`01_Konzeption_und_Strategie/01_Recherche_und_Analyse\`
- Technische Logdateien (Server) → in \`03_Betrieb_und_Optimierung/06_Wartung_und_Support\`
- Kampagnenplanung → in \`03_Betrieb_und_Optimierung/02_Marketing_und_Redaktion\`
EOF
            ;;
        "03_Betrieb_und_Optimierung/04_Social_Media_und_Community")
            cat <<EOF
# 04_Social_Media_und_Community

Dokumente zur Pflege von Social-Media-Kanälen und Community-Management: Posting-Pläne, Community-Richtlinien, Antwortvorlagen, Auswertungen von Social-Media-Metriken.

**Beispiele:**
- Social_Media_Redaktionsplan.xlsx
- Community_Richtlinien.md
- Antwortvorlagen_Support.csv
- Social_Media_Report_Q1.pdf
- Influencer_Kontaktliste.csv

**Nicht hierher gehören:**
- Allgemeine Marketingkampagnen → in \`03_Betrieb_und_Optimierung/02_Marketing\`
- Strategische Überlegungen zu Social Media → in \`01_Konzeption_und_Strategie/05_Content_Strategie\`
- Technische Integration von Social-Media-APIs → in \`02_Umsetzung_und_Entwicklung/05_Backend\`
EOF
            ;;
        "03_Betrieb_und_Optimierung/05_SEO_und_Suchmaschinenoptimierung")
            cat <<EOF
# 05_SEO_und_Suchmaschinenoptimierung

Alle Maßnahmen zur Suchmaschinenoptimierung im laufenden Betrieb: Keyword-Tracking, technische SEO-Audits, Optimierungsvorschläge, Backlink-Analysen, Monitoring der Rankings.

**Beispiele:**
- Keyword_Rankings_April.xlsx
- Technisches_SEO_Audit.pdf
- Optimierungsliste.md
- Backlink_Analyse.csv
- Search_Console_Daten/

**Nicht hierher gehören:**
- Keyword-Recherche (strategisch) → in \`01_Konzeption_und_Strategie/05_Content_Strategie\`
- Content-Produktion → in \`02_Umsetzung_und_Entwicklung/02_Textproduktion\`
- Grundlegende technische Konzeption → in \`01_Konzeption_und_Strategie/06_Technische_Konzeption\`
EOF
            ;;
        "03_Betrieb_und_Optimierung/06_Wartung_und_Support")
            cat <<EOF
# 06_Wartung_und_Support

Dokumente zur technischen Wartung, Updates, Sicherheitspatches, Support-Tickets, Known Issues, Wartungsprotokolle, Wiederherstellungspläne.

**Beispiele:**
- Wartungsprotokoll_2026.md
- Update_Checkliste.md
- Sicherheitsvorfall_Bericht.pdf
- Support_Ticket_Statistik.xlsx
- Known_Issues.md

**Nicht hierher gehören:**
- Launch-Dokumente → in \`03_Betrieb_und_Optimierung/01_Launch\`
- Marketingaktivitäten → in \`03_Betrieb_und_Optimierung/02_Marketing\`
- Code-Repositories → in \`02_Umsetzung_und_Entwicklung/04_05\`
EOF
            ;;
        "03_Betrieb_und_Optimierung/07_KI_Operations_und_Prompt_Management")
            cat <<EOF
# 07_KI_Operations_und_Prompt_Management

Betreuung und Dokumentation von KI-Assistenten und automatisierten Systemen: Prompt-Bibliotheken, Versionsverwaltung von Prompts, Monitoring der KI-Ausgaben, Ethik-Richtlinien für den Betrieb, Kostenkontrolle.

**Beispiele:**
- Prompt_Library_Support.md
- KI_Output_Qualitaetscheck.xlsx
- Kostenreport_OpenAI_API.pdf
- Richtlinien_KI_Einsatz.md
- Versionshistorie_Prompts/

**Nicht hierher gehören:**
- Strategische Planung von KI-Einsatz → in \`01_Konzeption_und_Strategie\`
- Entwicklung eigener KI-Modelle → in \`02_Umsetzung_und_Entwicklung/05_Backend\`
- Allgemeine Datenschutzdokumente → in \`00_Projektbasis/04_Recht\`
EOF
            ;;
        "04_Projekttypen_und_Branchen")
            cat <<EOF
# 04_Projekttypen_und_Branchen

Hier werden alle Projekte nach ihrer Art oder Branche sortiert abgelegt. Die Unterordner enthalten jeweils projektspezifische Dokumente, die nach dem gleichen Schema strukturiert sein können (z.B. eigene 00-03 Ordner).

**Beispiele:**
- Sammlung von Projektreferenzen
- Branchenanalysen
- Typische Anforderungen pro Projekttyp

**Nicht hierher gehören:**
- Allgemeine Methoden und Prozesse → in den Ordnern 00-03
- Persönliche Notizen → in \`99_Archiv\`
EOF
            ;;
        "04_Projekttypen_und_Branchen/01_Unternehmenspraesenz_und_Corporate")
            cat <<EOF
# 01_Unternehmenspraesenz_und_Corporate

Projekte, die sich mit klassischen Unternehmenswebsites, Corporate Blogs, Investor-Relations-Portalen und Intranets befassen. Hier landen alle projektspezifischen Dokumente.

**Beispiele:**
- Corporate_Website_Projekt_A/
- Investor_Relations_Microsite/
- Mitarbeiterportal_Doku/

**Nicht hierher gehören:**
- E-Commerce-Projekte → in \`04_Projekttypen_und_Branchen/02_E_Commerce\`
- E-Learning-Plattformen → in \`04_Projekttypen_und_Branchen/05_E_Learning\`
- Allgemeine Konzepte → in 00-03
EOF
            ;;
        "04_Projekttypen_und_Branchen/02_E_Commerce_und_Plattformen")
            cat <<EOF
# 02_E_Commerce_und_Plattformen

Alle Projekte rund um Online-Shops, Marktplätze, Booking-Plattformen und digitale Produkte (SaaS, Downloads). Inklusive Shop-System-Konfigurationen, Zahlungsintegration, Produktdaten.

**Beispiele:**
- Shop_Projekt_B_Shopify/
- Marktplatz_Plattform_C/
- Abomodell_Integration/

**Nicht hierher gehören:**
- Unternehmenswebsites → in \`01_Unternehmenspraesenz\`
- Mobile Apps (falls nicht zum Shop gehörig) → ggf. eigener Ordner, hier nicht vorgesehen
- Content-Strategien → in 01-05
EOF
            ;;
        "04_Projekttypen_und_Branchen/03_Unterhaltung_und_Medien")
            cat <<EOF
# 03_Unterhaltung_und_Medien

Projekte aus den Bereichen Gaming, Video-Streaming, Musikplattformen, interaktive Erlebnisse, Augmented Reality (AR)/Virtual Reality (VR)-Anwendungen.

**Beispiele:**
- Gaming_Portal_D/
- AR_Erlebnis_App_E/
- Video_Plattform_F/

**Nicht hierher gehören:**
- E-Learning (spielerisch) → in \`05_E_Learning\`
- Soziale Netzwerke → in \`04_Social_Media\` (als Betriebsthema) oder eigener Projekttyp
- Allgemeine Designkonzepte → in 01-04
EOF
            ;;
        "04_Projekttypen_und_Branchen/04_Vereine_und_NGOs")
            cat <<EOF
# 04_Vereine_und_NGOs

Spezifische Projekte für Vereine, Non-Profit-Organisationen, Stiftungen. Oft mit Mitgliederverwaltung, Spendenfunktionen, Ehrenamtskoordination.

**Beispiele:**
- Vereinswebsite_G/
- Spendenplattform_H/
- Mitgliederverwaltung_I/

**Nicht hierher gehören:**
- Kommerzielle Unternehmensseiten → in \`01_Unternehmenspraesenz\`
- E-Government (Behörden) → könnte ein eigener Typ sein, hier nicht vorgesehen, ggf. in \`08_Intranets\` oder neu anlegen
- Allgemeine Vorlagen → in 05-03_Templates
EOF
            ;;
        "04_Projekttypen_und_Branchen/05_E_Learning_und_Wissensvermittlung")
            cat <<EOF
# 05_E_Learning_und_Wissensvermittlung

Projekte rund um Lernplattformen, Online-Kurse, Wissensdatenbanken, Trainingsportale, inklusive Autorentools, LMS-Systeme, KI-Tutoren.

**Beispiele:**
- Kursplattform_J/
- Lernapp_K/
- Wissensdatenbank_L/
- KI_Tutor_Prototyp/

**Nicht hierher gehören:**
- Unternehmens-Intranets (oft auch mit Lerninhalten) → in \`08_Intranets\`
- Einfache Blogs → in \`01_Unternehmenspraesenz\`
- Konzeption von Lerninhalten → in 01-05 (Content-Strategie)
EOF
            ;;
        "04_Projekttypen_und_Branchen/06_SaaS_und_Digitale_Produkte")
            cat <<EOF
# 06_SaaS_und_Digitale_Produkte

Projekte, die Software-as-a-Service-Produkte, Apps oder digitale Tools entwickeln. Hier liegen Produkt-Roadmaps, Release-Pläne, Pricing-Konzepte, Dokumentationen für Nutzer.

**Beispiele:**
- SaaS_Produkt_M_Roadmap/
- App_N_Dokumentation/
- Pricing_Modell_O.xlsx

**Nicht hierher gehören:**
- E-Commerce-Shops (physische Produkte) → in \`02_E_Commerce\`
- Einmalige Websites → in \`01_Unternehmenspraesenz\`
- Technische Entwicklungscode → in 02-04/05 (kann hier aber als Unterordner abgebildet sein)
EOF
            ;;
        "04_Projekttypen_und_Branchen/07_KI_Assistenten_und_Chatbots")
            cat <<EOF
# 07_KI_Assistenten_und_Chatbots

Projekte, die sich auf die Entwicklung und den Betrieb von KI-gestützten Assistenten, Chatbots, Voicebots konzentrieren. Inklusive Dialogdesign, NLU-Training, Prompt-Flows.

**Beispiele:**
- Kundenservice_Chatbot_P/
- Voice_Assistant_Q/
- Prompt_Engineering_Projekt_R/

**Nicht hierher gehören:**
- Allgemeine KI-Operations → in \`03-07_KI_Operations\`
- Strategische KI-Planung → in \`01_Konzeption\`
- Integration von Chatbots in bestehende Seiten → könnte in anderen Projekttypen als Teilprojekt landen
EOF
            ;;
        "04_Projekttypen_und_Branchen/08_Intranets_und_Digitale_Arbeitsplaetze")
            cat <<EOF
# 08_Intranets_und_Digitale_Arbeitsplaetze

Projekte für interne Unternehmenslösungen: Intranet, Mitarbeiter-Apps, Wissensmanagement, DMS (Dokumentenmanagementsysteme), Collaboration-Tools.

**Beispiele:**
- Intranet_AG/
- Mitarbeiter-App_S/
- DMS_Einfuehrung_T/

**Nicht hierher gehören:**
- Externe Unternehmenswebsites → in \`01_Unternehmenspraesenz\`
- E-Learning-Plattformen für externe → in \`05_E_Learning\`
- Allgemeine Sicherheitskonzepte → in 01-06
EOF
            ;;
        "05_Ressourcen_und_Templates")
            cat <<EOF
# 05_Ressourcen_und_Templates

Hier werden alle wiederverwendbaren Vorlagen, Checklisten, Tool-Listen und ein Glossar gesammelt. Dient als Baukasten für neue Projekte.

**Beispiele:**
- Vorlagen für Angebote, Briefings, Konzepte
- Nützliche Linksammlungen
- Tool-Empfehlungen

**Nicht hierher gehören:**
- Projektspezifische Dokumente → in 00-04
- Persönliche Notizen → in \`99_Archiv\`
EOF
            ;;
        "05_Ressourcen_und_Templates/01_Checklisten")
            cat <<EOF
# 01_Checklisten

Sammlung aller Checklisten für verschiedene Projektphasen und -typen: Briefing-Checkliste, Launch-Checkliste, SEO-Checkliste, Barrierefreiheits-Checkliste, etc.

**Beispiele:**
- Briefing_Checkliste.md
- Launch_Checkliste_Allgemein.md
- SEO_Checkliste_Technisch.md
- Barrierefreiheit_Pruefliste.pdf

**Nicht hierher gehören:**
- Ausgefüllte Checklisten aus konkreten Projekten → in den jeweiligen Projektordnern (z.B. 00-03 oder 04)
- Vorlagen für andere Zwecke → in \`05_Ressourcen_und_Templates/03_Templates\`
EOF
            ;;
        "05_Ressourcen_und_Templates/02_Links_und_Literatur")
            cat <<EOF
# 02_Links_und_Literatur

Sammlung von hilfreichen Links, Fachartikeln, Büchern, Tutorials, Blogs und anderen externen Ressourcen.

**Beispiele:**
- Links_Designsysteme.md
- Literaturliste_Projektmanagement.md
- Tutorials_KI_Programmierung.md
- Fachblogs_Webentwicklung.opml

**Nicht hierher gehören:**
- Interne Vorlagen → in \`03_Templates\`
- Tools (Software) → in \`04_Tools_und_Software\`
- Persönliche Lesezeichen (zu privat) → ggf. in \`99_Archiv\`
EOF
            ;;
        "05_Ressourcen_und_Templates/03_Templates")
            cat <<EOF
# 03_Templates

Wiederverwendbare Dateivorlagen für alle möglichen Zwecke: Briefing-Vorlage, Angebotsvorlage, Projektplan-Vorlage, Meetingprotokoll-Vorlage, Code-Snippets.

**Beispiele:**
- Vorlage_Briefing.docx
- Vorlage_Angebot.ott
- Vorlage_Projektplan_Gantt.xltx
- Meetingprotokoll_Template.md
- Code_Snippets_React.js

**Nicht hierher gehören:**
- Checklisten (sind spezifischer) → in \`01_Checklisten\`
- Tools und Software-Bewertungen → in \`04_Tools_und_Software\`
- Ausgefüllte Dokumente → in den Projektordnern
EOF
            ;;
        "05_Ressourcen_und_Templates/04_Tools_und_Software")
            cat <<EOF
# 04_Tools_und_Software

Bewertungen, Vergleiche und Lizenzinformationen zu Software und Tools, die im Arbeitsalltag genutzt werden: Projektmanagement-Tools, Designtools, Entwicklungsumgebungen, KI-Tools.

**Beispiele:**
- Vergleich_Projektmanagement_Tools.xlsx
- KI-Tools_Uebersicht.md
- Lizenzkosten_Adobe Creative Cloud.pdf
- OpenSource_Alternativen.md

**Nicht hierher gehören:**
- Konkrete Konfigurationen eines Tools für ein Projekt → in den Projektordnern
- Link- und Literatursammlung → in \`02_Links_und_Literatur\`
- Templates für Tools (z.B. Jira-Vorlagen) → in \`03_Templates\`
EOF
            ;;
        "05_Ressourcen_und_Templates/05_Glossar_und_Fachbegriffe")
            cat <<EOF
# 05_Glossar_und_Fachbegriffe

Ein wachsendes Glossar mit Definitionen wichtiger Fachbegriffe aus den Bereichen Projektmanagement, Webentwicklung, Marketing, KI, Recht, etc.

**Beispiele:**
- Glossar_Agile_Methoden.md
- Fachbegriffe_SEO.md
- Definitionen_KI_ML.md
- Abkuerzungen_Webentwicklung.md

**Nicht hierher gehören:**
- Detaillierte Erklärungen (Wiki-Stil) → eher in die jeweiligen Fachordner
- Persönliche Notizen → in \`99_Archiv\`
EOF
            ;;
        "99_Archiv")
            cat <<EOF
# 99_Archiv

Hier werden abgeschlossene Projekte, alte Versionen von Dokumenten und nicht mehr aktuelle Materialien verschoben, um das Hauptverzeichnis sauber zu halten.

**Beispiele:**
- Abgeschlossenes_Projekt_2024/
- Alte_Vorlagen/
- Nicht_mehr_verwendete_Konzepte/

**Nicht hierher gehören:**
- Aktuelle Projekte und Dokumente
- Wichtige, noch gültige Ressourcen
- Persönliche Notizen, die keinen Bezug zur Arbeit haben (privat halten)
EOF
            ;;
        *)
            # Fallback für nicht definierte Ordner (sollte nicht vorkommen)
            cat <<EOF
# $(basename "$folder")

Dieser Ordner ist Teil der Wissensrepository-Struktur. Bitte fügen Sie hier eine passende README.md mit einer Beschreibung ein.

**Beispiele für Dateien:**
- ...

**Nicht hierher gehören:**
- ...
EOF
            ;;
    esac
}

# ============================================
# Hauptprogramm
# ============================================

# Prüfen, ob das Basisverzeichnis existiert, sonst erstellen
if [ ! -d "$BASE_DIR" ]; then
    echo "Basisverzeichnis $BASE_DIR existiert nicht. Bitte zuerst das Struktur-Skript ausführen."
    exit 1
fi

echo "Generiere README.md für alle Ordner in $BASE_DIR ..."

# Alle Ordner unterhalb von BASE_DIR finden (nur Verzeichnisse)
find "$BASE_DIR" -type d | while read -r dir; do
    # Relativen Pfad zum BASE_DIR ermitteln
    rel_path="${dir#$BASE_DIR/}"
    # Wenn der Pfad gleich dem BASE_DIR ist, rel_path auf "" setzen
    if [ "$dir" = "$BASE_DIR" ]; then
        rel_path=""
    fi

    # Inhalt generieren
    content=$(generate_readme_content "$rel_path")

    # README.md schreiben
    echo "$content" > "$dir/README.md"
    echo "  README.md erstellt in: $dir"
done

# ============================================
# Erstellung der zentralen llms.md
# ============================================
echo ""
echo "Generiere llms.md im Hauptverzeichnis ..."

LLM_FILE="$BASE_DIR/llms.md"
{
    echo "# LLM-kompatible Repräsentation des Wissensrepositoriums"
    echo ""
    echo "Dieses Dokument fasst alle README.md-Dateien der Ordnerstruktur zusammen."
    echo "Es dient als Eingabe für LLM-Agenten, um ein Verständnis der Ablagestruktur zu ermöglichen – ideal für die Einbettung in eine Vektordatenbank (z.B. Chroma DB) oder für automatische Verschlagwortung."
    echo ""
    echo "---"
    echo ""

    # Wieder alle Ordner durchgehen und README.md einfügen
    find "$BASE_DIR" -type d | sort | while read -r dir; do
        rel_path="${dir#$BASE_DIR/}"
        if [ "$dir" = "$BASE_DIR" ]; then
            rel_path="."
        fi

        readme_file="$dir/README.md"
        if [ -f "$readme_file" ]; then
            echo "## Ordner: $rel_path"
            echo ""
            cat "$readme_file"
            echo ""
            echo "---"
            echo ""
        fi
    done
} > "$LLM_FILE"

echo "✅ llms.md wurde unter $LLM_FILE erstellt."
echo ""
echo "Fertig! Alle README.md und llms.md wurden generiert."