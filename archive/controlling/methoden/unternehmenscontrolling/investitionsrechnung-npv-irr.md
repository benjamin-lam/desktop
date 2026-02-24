# Methode: Investitionsrechnung (NPV / IRR / Payback)

**Kategorie:** Unternehmenscontrolling  
**Ziel:** Wirtschaftlichkeit von Investitionen bewerten und Projekte vergleichbar machen.  
**Typische Einsatzfälle:** Capex-Entscheidungen, Software-Build-vs-Buy, Maschinenkauf, Marketing-Großprojekte.

---

## 1) Zweck & Business-Nutzen
- Bewertet **Kapitalwert** (NPV) und **Rendite** (IRR) unter Zeitwert des Geldes.
- Vergleich von Alternativen (Projekt A vs. B) auf **Cashflow-Basis**.

## 2) Daten & Inputs
- Anfangsinvestition (Capex)  
- Erwartete Netto-Cashflows je Periode (Einzahlungen − Auszahlungen)  
- Diskontsatz (WACC / Mindestverzinsung)  
- Projektlaufzeit, Restwert

## 3) Vorgehen (Schritt für Schritt)
1. Cashflows je Periode schätzen (konservativ, Szenarien).  
2. Diskontsatz festlegen (z. B. WACC).  
3. **NPV** und **IRR** berechnen; **Payback** ergänzen.  
4. Sensitivität: Preis, Menge, Kosten, Diskontsatz variieren.

## 4) Formeln & Beispiele
- **NPV:** `NPV = Σ [ CF_t / (1 + r)^t ] − I0`  
- **IRR:** Zinssatz `r`, für den `NPV = 0`. (numerisch)  
- **Payback:** Perioden bis kumulierter Cashflow ≥ I0.  
- **Mini-Beispiel:** I0 = 100k; CF1..3 = 50k/40k/30k; r = 10% → NPV ≈ 6,1k → **annehmen**.

## 5) Interpretation & Maßnahmen
- **NPV > 0**: Wertbeitrag; **IRR > r**: Rendite über Hürde.  
- Engpassressourcen auf höchste NPV/IRR priorisieren.

## 6) Grenzen, Annahmen & typische Fehler
- Cashflow-Schätzungen zu optimistisch.  
- Diskontsatz falsch (Risiko/Inflation ignoriert).  
- **IRR-Fallstricke** (mehrfache Vorzeichenwechsel).

## 7) Checklisten
**DoR:** [ ] Cashflow-Plan, [ ] r definiert, [ ] Szenarien (Base/Best/Worst)  
**DoD:** [ ] NPV/IRR/Payback dokumentiert, [ ] Sensitivität anhängen, [ ] Entscheidung + Begründung

## 8) Verknüpfungen
- Verwandt: [Szenario- & Sensitivitätsanalyse](szenario-und-sensitivitaet.md), [Rolling Forecast](rolling-forecast.md)  
- KPIs: ROI, EBIT-Effekt, Cash Conversion  
- Tools: Excel/Python, BI

## 9) Beispiel-Output
```text
Methode: Investitionsrechnung
Projekt: Shop-Replatforming
I0: 350.000 €
Cashflows (3 Jahre): 140k / 160k / 120k
r (WACC): 9%
Ergebnis: NPV +51k; IRR 13,4%; Payback 2,2 Jahre → Empfehlung: Go (mit Phasen-Gates)
```

---

## Verknüpfungen
- **Geschäftsmodelle:** [B2B](../../../business-models/b2b.md), [B2C](../../../business-models/b2c.md), [D2C](../../../business-models/d2c.md), [B2G](../../../business-models/b2g.md)
- **Zielgruppen:** [Unternehmen](../../../zielgruppen/unternehmen.md), [Endkund:innen](../../../zielgruppen/endkundinnen.md), [Behörden](../../../zielgruppen/behoerden.md)
- **Vertriebswege:** [Onlineshop](../../../vertriebswege/onlineshop.md), [Partnernetzwerke](../../../vertriebswege/partnernetzwerke.md), [Stationär](../../../vertriebswege/stationaer.md), [Ausschreibungsportale](../../../vertriebswege/ausschreibungsportale.md)
- **Erlösmodelle:** [Direktverkauf](../../../erloesmodelle/direktverkauf.md), [Abonnement](../../../erloesmodelle/abonnement.md), [Lizenz](../../../erloesmodelle/lizenz.md), [Pay-per-Use](../../../erloesmodelle/pay-per-use.md)
