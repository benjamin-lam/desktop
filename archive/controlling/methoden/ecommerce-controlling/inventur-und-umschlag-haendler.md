# Methode: Lager- & Inventory-Umschlag (Händler:innen)

**Kategorie:** E-Commerce-Controlling  
**Ziel:** Bestände optimal steuern, Kapitalbindung minimieren und Lieferfähigkeit sichern.  
**Typische Einsatzfälle:** Sortimentspflege, Saisongeschäft, Working-Capital-Optimierung, Lieferantensteuerung.

---

## 1) Zweck & Business-Nutzen
- Sichtbar machen, welche Artikel Über- oder Unterbestand haben.  
- Kapitalbindung und Abschriften reduzieren, Verfügbarkeit erhöhen.

## 2) Daten & Inputs
- Lagerbestände je SKU, Wareneinsatz/COGS, Abverkaufsmengen.  
- Lieferzeiten, Mindestbestände, Sicherheitsbestände.  
- Retourenquoten, Saisonkalender.

## 3) Vorgehen (Schritt für Schritt)
1. Umschlagshäufigkeit und Days of Inventory (DOI) je SKU/Bereich berechnen.  
2. ABC-/XYZ-Analyse kombinieren (Wert vs. Volatilität).  
3. Über-/Unterbestände identifizieren und Maßnahmen definieren (Abverkauf, Nachbestellung, Nachdisposition).  
4. Monitoring in S&OP-/Forecast-Prozesse integrieren.

## 4) Formeln & Beispiele
- **Inventory Turnover:** `COGS / Ø Bestand`  
- **Days of Inventory:** `365 / Inventory Turnover`  
- **Beispiel:** COGS 2 Mio. €, Ø Bestand 0,4 Mio. € → Turnover = 5, DOI = 73 Tage.

## 5) Interpretation & Maßnahmen
- Niedriger Turnover/hoher DOI → Abverkauf, Bundles, Preisaktionen.  
- Hoher Turnover/niedriger DOI → Nachbestellen, Lieferanten-Agilität sichern.

## 6) Grenzen, Annahmen & typische Fehler
- Saisonale Peaks nicht berücksichtigen → Fehlentscheidungen.  
- Fehlende Datenqualität (Inventurdifferenzen, SKU-Hierarchie).  
- Nur Gesamtwerte statt Kategorie-/SKU-Sicht.

## 7) Checklisten
**DoR:** [ ] Bestandshistorie vollständig, [ ] Forecast aktualisiert, [ ] Lieferzeiten validiert  
**DoD:** [ ] Maßnahmenliste je SKU-Klasse, [ ] Cash-Effekt quantifiziert, [ ] Reviewtermin fixiert

## 8) Verknüpfungen
- Verwandt: [Working-Capital-Controlling](../unternehmenscontrolling/arbeitskapital-controlling.md), [RFM & Basket Analysis](rfm-und-basket-analysis.md)  
- KPIs: Inventory Turnover, DOI, Out-of-Stock Rate  
- Tools: ERP/WMS, BI, Forecasting-Tools

## 9) Beispiel-Output
```text
Methode: Inventory-Umschlag
Zeitraum: Q3/2025
Ergebnis: ABC-A-Artikel Turnover 9 (OK); C-Artikel DOI 180 → Abverkaufskampagne nötig
Maßnahmen: Flash-Sale C-Artikel (Mira, 10.10.), Lieferantenvertrag A-Artikel verlängern (Tom, 30.10.)
Review: Monatlich
```
