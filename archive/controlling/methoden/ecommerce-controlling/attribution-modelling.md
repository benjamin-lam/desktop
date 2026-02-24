# Methode: Attribution Modelling

**Kategorie:** E-Commerce-Controlling  
**Ziel:** Marketing- und Vertriebskanäle fair bewerten, indem Touchpoints entlang der Customer Journey analysiert werden.  
**Typische Einsatzfälle:** Budgetallokation, Kanalbewertung, Performance-Optimierung.

---

## 1) Zweck & Business-Nutzen
- Versteht den Beitrag einzelner Kanäle zur Conversion.  
- Unterstützt datenbasierte Budgetentscheidungen und Bid-Strategien.

## 2) Daten & Inputs
- Customer-Journey-Daten (Sessions, Kampagnen, Touchpoints).  
- Conversion-Events (Käufe, Leads) inkl. Timestamp & Wert.  
- Kanal-/Kampagnenkosten.

## 3) Vorgehen (Schritt für Schritt)
1. Tracking-Setup prüfen (UTMs, IDs, Consent).  
2. Modell wählen: Last-/First-Click, Positionsbasiert, Zeitverlauf, Data-Driven (Markov/Shapley).  
3. Conversion-Werte pro Kanal berechnen.  
4. Ergebnisse mit Spend verknüpfen und Maßnahmen ableiten.

## 4) Formeln & Beispiele
- **ROAS je Kanal:** `ROAS = Umsatz_attribuiert / Kosten`  
- **Markov Removal Effect:** Differenz der Conversion-Rate bei Kanalentfernung.  
- Beispiel: Kanal X Removal Effect = −18% → hoher Beitrag.

## 5) Interpretation & Maßnahmen
- Kanäle mit negativem ROAS optimieren oder pausieren.  
- Attributionsergebnisse in Budgetplanung & Forecast integrieren.

## 6) Grenzen, Annahmen & typische Fehler
- Datenlücken (Tracking-Loss, Consent).  
- Fehlende Offline-/CRM-Daten → Verzerrungen.  
- Modelle vergleichen, um Extremwerte zu validieren.

## 7) Checklisten
**DoR:** [ ] Tracking-Plan, [ ] Kanalhierarchie, [ ] Kostendaten integriert  
**DoD:** [ ] Attribution-Report, [ ] Handlungsempfehlungen, [ ] Review-Zyklus

## 8) Verknüpfungen
- Verwandt: [Conversion Funnel & A/B-Testing](conversion-funnel-und-ab-test.md), [Unit Economics](unit-economics-ltv-cac.md)  
- KPIs: ROAS, CPA, Assisted Conversions  
- Tools: GA4, MMP, BI, Python

## 9) Beispiel-Output
```text
Methode: Attribution Modelling
Zeitraum: Q3/2025
Ergebnis: Data-Driven Modell → Paid Social +18% Wertbeitrag ggü. Last-Click, SEA −9%
Maßnahmen: SEA-Brand-Budget -10% (Nina, 01.11.), Paid Social Upper Funnel +15% (Elisa, 05.11.)
Review: Monatlich
```
