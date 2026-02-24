#!/bin/bash
# Desktop (Stand 2026)
# Benjamin Lam (blame76)
# Basis-Verzeichnis – hier können Sie den Namen bei Bedarf ändern
BASE_DIR="./volumes/repo/"

echo "Erstelle Verzeichnisstruktur in '$BASE_DIR' ..."

# 00_Projektbasis
mkdir -p "$BASE_DIR/00_Projektbasis/01_Briefing_und_Scoping"
mkdir -p "$BASE_DIR/00_Projektbasis/02_Angebot_und_Kalkulation"
mkdir -p "$BASE_DIR/00_Projektbasis/03_Projektphasen_und_Meilensteine"
mkdir -p "$BASE_DIR/00_Projektbasis/04_Recht_und_Datenschutz"

# 01_Konzeption_und_Strategie
mkdir -p "$BASE_DIR/01_Konzeption_und_Strategie/01_Recherche_und_Analyse"
mkdir -p "$BASE_DIR/01_Konzeption_und_Strategie/02_Grobkonzept"
mkdir -p "$BASE_DIR/01_Konzeption_und_Strategie/03_Feinkonzept"
mkdir -p "$BASE_DIR/01_Konzeption_und_Strategie/04_Design_und_UX_Strategie"
mkdir -p "$BASE_DIR/01_Konzeption_und_Strategie/05_Content_Strategie"
mkdir -p "$BASE_DIR/01_Konzeption_und_Strategie/06_Technische_Konzeption"

# 02_Umsetzung_und_Entwicklung
mkdir -p "$BASE_DIR/02_Umsetzung_und_Entwicklung/01_UX_Usability_Tests"
mkdir -p "$BASE_DIR/02_Umsetzung_und_Entwicklung/02_Textproduktion"
mkdir -p "$BASE_DIR/02_Umsetzung_und_Entwicklung/03_Grafik_und_Medienproduktion"
mkdir -p "$BASE_DIR/02_Umsetzung_und_Entwicklung/04_Frontend_Entwicklung"
mkdir -p "$BASE_DIR/02_Umsetzung_und_Entwicklung/05_Backend_Entwicklung_und_Integration"
mkdir -p "$BASE_DIR/02_Umsetzung_und_Entwicklung/06_Testing_und_Qualitaetssicherung"

# 03_Betrieb_und_Optimierung
mkdir -p "$BASE_DIR/03_Betrieb_und_Optimierung/01_Launch_und_Go-Live"
mkdir -p "$BASE_DIR/03_Betrieb_und_Optimierung/02_Marketing_und_Redaktion"
mkdir -p "$BASE_DIR/03_Betrieb_und_Optimierung/03_Analytics_und_Data_Insights"
mkdir -p "$BASE_DIR/03_Betrieb_und_Optimierung/04_Social_Media_und_Community"
mkdir -p "$BASE_DIR/03_Betrieb_und_Optimierung/05_SEO_und_Suchmaschinenoptimierung"
mkdir -p "$BASE_DIR/03_Betrieb_und_Optimierung/06_Wartung_und_Support"
mkdir -p "$BASE_DIR/03_Betrieb_und_Optimierung/07_KI_Operations_und_Prompt_Management"

# 04_Projekttypen_und_Branchen
mkdir -p "$BASE_DIR/04_Projekttypen_und_Branchen/01_Unternehmenspraesenz_und_Corporate"
mkdir -p "$BASE_DIR/04_Projekttypen_und_Branchen/02_E_Commerce_und_Plattformen"
mkdir -p "$BASE_DIR/04_Projekttypen_und_Branchen/03_Unterhaltung_und_Medien"
mkdir -p "$BASE_DIR/04_Projekttypen_und_Branchen/04_Vereine_und_NGOs"
mkdir -p "$BASE_DIR/04_Projekttypen_und_Branchen/05_E_Learning_und_Wissensvermittlung"
mkdir -p "$BASE_DIR/04_Projekttypen_und_Branchen/06_SaaS_und_Digitale_Produkte"
mkdir -p "$BASE_DIR/04_Projekttypen_und_Branchen/07_KI_Assistenten_und_Chatbots"
mkdir -p "$BASE_DIR/04_Projekttypen_und_Branchen/08_Intranets_und_Digitale_Arbeitsplaetze"

# 05_Ressourcen_und_Templates
mkdir -p "$BASE_DIR/05_Ressourcen_und_Templates/01_Checklisten"
mkdir -p "$BASE_DIR/05_Ressourcen_und_Templates/02_Links_und_Literatur"
mkdir -p "$BASE_DIR/05_Ressourcen_und_Templates/03_Templates"
mkdir -p "$BASE_DIR/05_Ressourcen_und_Templates/04_Tools_und_Software"
mkdir -p "$BASE_DIR/05_Ressourcen_und_Templates/05_Glossar_und_Fachbegriffe"

# 99_Archiv
mkdir -p "$BASE_DIR/99_Archiv"

echo "✅ Struktur erfolgreich in '$BASE_DIR' angelegt."