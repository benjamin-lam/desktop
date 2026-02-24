# Methode: Szenario- & Sensitivitätsanalyse

**Kategorie:** Unternehmenscontrolling  
**Ziel:** Unsicherheiten und Treiberwirkungen transparent machen, um robuste Entscheidungen zu treffen.  
**Typische Einsatzfälle:** Budget-/Forecast-Unsicherheit, Investitionsentscheidungen, Risikoanalysen.

---

## 1) Zweck & Business-Nutzen
- Zeigt Bandbreiten möglicher Ergebnisse (Best/Expected/Worst Case).
- Identifiziert kritische Treiber mit größtem Einfluss.

## 2) Daten & Inputs
- Baseline-Planung (P&L, Cashflow, KPIs).
- Treiberannahmen (Preise, Mengen, Kosten, Konversionsraten).
- Externe Faktoren (Markt, Regulierung, Wechselkurse).

## 3) Vorgehen (Schritt für Schritt)
1. Relevante Treiber definieren und Variation festlegen.  
2. Szenarien modellieren (z. B. Base, Optimistic, Pessimistic).  
3. Sensitivitätsanalyse durchführen (z. B. Tornado-Diagramm, What-if).  
4. Maßnahmen und Triggerpunkte ableiten.

## 4) Formeln & Beispiele
- **Delta-Analyse:** `ΔErgebnis = ∂Ergebnis/∂Treiber × ΔTreiber`  
- **Beispiel:** Conversion +0,2pp → Umsatz +3%, EBIT +1,1 Mio. €.

## 5) Interpretation & Maßnahmen
- Fokus auf Treiber mit hohem Impact und hoher Unsicherheit.  
- Frühwarnindikatoren definieren und Monitoring etablieren.

## 6) Grenzen, Annahmen & typische Fehler
- Unvollständige Treibermodelle → Scheinsicherheit.  
- Szenarien ohne Maßnahmen → begrenzter Nutzen.

## 7) Checklisten
**DoR:** [ ] Treibermodell, [ ] Datenstand aktuell, [ ] Stakeholder abgestimmt  
**DoD:** [ ] Szenarien dokumentiert, [ ] Maßnahmen + Trigger, [ ] Kommunikationsplan

## 8) Verknüpfungen
- Verwandt: [Rolling Forecast](rolling-forecast.md), [Investitionsrechnung](investitionsrechnung-npv-irr.md)  
- KPIs: Forecast Accuracy, EBIT, Cashflow  
- Tools: BI, Simulation, Python/Excel

## 9) Beispiel-Output
```text
Methode: Szenario- & Sensitivitätsanalyse
Zeitraum: FY 2026 Planung
Ergebnis: Worst Case EBIT 9% vs. Base 14%; Conversion Treiber höchster Impact
Maßnahmen: Pricing-Tests +2% (Lea, 15.11.), Kostenflex-Plan aktivieren (Jonas, 30.11.)
Review: Monatlich
```
