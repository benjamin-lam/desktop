# Methode: Conversion Funnel & A/B-Testing Impact

**Kategorie:** E-Commerce-Controlling  
**Ziel:** Conversion-Lecks finden, Hypothesen testen, Impact quantifizieren.

---

## 1) Zweck & Business-Nutzen
- Priorisierte Optimierungen entlang des Funnels (Landing → PDP → Cart → Checkout).
- Messbarer Uplift statt Bauchgefühl.

## 2) Daten & Inputs
- Sitzungen/Visitors, Step-Through-Rates, CR, AOV
- Testmetrik (z. B. CR oder Revenue/Visitor), Power/Signifikanz

## 3) Vorgehen (Schritt für Schritt)
1. Funnel modellieren & Engpässe identifizieren.  
2. Hypothesen + Impact / Confidence / Effort (ICE) priorisieren.  
3. A/B-Test aufsetzen (Randomisierung, Dauer, Power).  
4. Ergebnis bewerten & ausrollen oder verwerfen.

## 4) Formeln & Beispiele
- **Conversion Rate:** `CR = Bestellungen / Sitzungen`  
- **Uplift:** `(CR_B − CR_A) / CR_A`

## 5) Interpretation & Maßnahmen
- Fokus auf **Hebel** (z. B. PDP Add-to-Cart Rate).  
- Serielle Tests statt parallelem „Test-Zoo“.

## 6) Grenzen & Fehler
- Unterpowerte Tests → Scheinsignifikanz.  
- Metrik-Drift (z. B. nur CTR statt Umsatz pro Besucher).

## 7) Checklisten
**DoR:** [ ] Funnel definiert, [ ] Hypothesen-Backlog, [ ] Testdesign geprüft  
**DoD:** [ ] A/B-Report, [ ] Code/Design dokumentiert, [ ] Rollout-Plan

## 8) Verknüpfungen
- Verwandt: [Attribution](attribution-modelling.md), [Unit Economics](unit-economics-ltv-cac.md)  
- KPIs: CR, AOV, RPV, Uplift  
- Tools: GA4, Experiment-Plattform, Feature-Flags

## 9) Beispiel-Output
```text
Methode: Funnel & A/B
Zeitraum: 15.–30.10.2025
Ergebnis: PDP-Uplift +7,2% CR (p<0,05), erwarteter Monatsumsatz +2,1%
Maßnahmen: Rollout Variante B (Nina, 05.11.), Folge-Test: Trust-Badges im Checkout (Jamal, 20.11.)
Review: 30.11.
```
