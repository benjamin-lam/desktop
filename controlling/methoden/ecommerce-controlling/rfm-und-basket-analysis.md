# Methode: RFM- & Basket-Analysis

**Kategorie:** E-Commerce-Controlling  
**Ziel:** Kundensegmente nach Kaufaktualität, Häufigkeit und monetärem Wert identifizieren sowie Warenkorbkombinationen verstehen.  
**Typische Einsatzfälle:** CRM-Segmentierung, Cross-/Upselling, Kampagnen-Personalisierung.

---

## 1) Zweck & Business-Nutzen
- Priorisierung von Loyalitäts- und Reaktivierungsmaßnahmen.  
- Identifikation von Cross-Selling-Potenzialen und Bundles.

## 2) Daten & Inputs
- Transaktionsdaten (Kaufdatum, Umsatz, Produkte, Kunde).  
- Kund:innen-Stammdaten, Produktkategorien.  
- Optional: Kampagnenkontakte, Rabattinformationen.

## 3) Vorgehen (Schritt für Schritt)
1. RFM-Scores pro Kund:in berechnen (Recency, Frequency, Monetary).  
2. Kundensegmente ableiten (z. B. Champions, At Risk, Hibernating).  
3. Warenkorb-/Assoziationsanalyse (z. B. Apriori, FP-Growth) durchführen.  
4. Maßnahmen und Kampagnen pro Segment planen.

## 4) Formeln & Beispiele
- **R-Score:** Ranking nach Tagen seit letztem Kauf (niedriger besser).  
- **F-Score:** Ranking nach # Käufen.  
- **M-Score:** Ranking nach Umsatz/Deckungsbeitrag.  
- **Lift:** `Lift = Support(ItemSet) / (Support(A) × Support(B))`

## 5) Interpretation & Maßnahmen
- Champions mit Loyalitätsprogrammen halten; „At Risk“ reaktivieren.  
- Basket-Insights nutzen für Bundles, Empfehlungen, Platzierungen.

## 6) Grenzen, Annahmen & typische Fehler
- Nur vergangenes Verhalten → neue Produkte/Preise berücksichtigen.  
- Datenqualität (z. B. Dubletten) entscheidend für Segmenttreue.  
- Lift-Werte kritisch prüfen (Stichprobengröße).

## 7) Checklisten
**DoR:** [ ] Transaktionsdaten bereinigt, [ ] Kund:innen-ID stabil, [ ] Produktklassifikation konsistent  
**DoD:** [ ] Segmente dokumentiert, [ ] Maßnahmen & Owner, [ ] Kampagnenplan aktualisiert

## 8) Verknüpfungen
- Verwandt: [Unit Economics](unit-economics-ltv-cac.md), [Cohort Analysis](cohort-analysis-und-churn.md)  
- KPIs: Average Order Value, Repeat Rate, Attach Rate  
- Tools: SQL/BI, Python, CRM/Marketing Automation

## 9) Beispiel-Output
```text
Methode: RFM & Basket
Zeitraum: FY 2025
Ergebnis: Champions-Segment 18% der Kunden → 46% Umsatz; Lift(Kaffee, Filter) = 3,1
Maßnahmen: VIP-Programm erweitern (Sven, 15.11.), Bundle „Kaffee+Filter“ launchen (Mira, 01.12.)
Review: Quartalsweise
```
