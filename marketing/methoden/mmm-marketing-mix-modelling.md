# Methode: Marketing Mix Modelling (MMM)

**Ziel:** Ökonometrisches Modell quantifiziert Kanaleffekte inkl. Offline, Saisonalität & Carryover.

## 1) Zweck & Nutzen
- Budgetallokation auf Gesamtwirkung, weniger Tracking-Bias.

## 2) Inputs
- Zeitreihen: Sales/Leads, Kanalspend, Preise, Promo, Saisonalität, externe Faktoren (Wetter, Konkurrenz).

## 3) Vorgehen
1. Datenaufbereitung (Lag/Carryover/Saturation).  
2. Modellierung (z. B. Bayes/Robust Regression).  
3. Validierung (Holdout, Posterior Predictive Checks).  
4. Response Curves & Budgetoptimierung.

## 4) Metriken
- MAPE/R², ROI je Kanal, Diminishing Returns.

## 5) Grenzen
- Aggregatniveau; Modellannahmen kritisch prüfen.

## 6) Checklisten
**DoR:** [ ] Vollständige Zeitreihen, [ ] Feature-Eng, [ ] Validierungsplan  
**DoD:** [ ] Response-Kurven, [ ] Budget-Plan, [ ] Monitoring

## 7) Verknüpfungen
- Attribution & UTM: `attribution-models.md`, `utm-taxonomy.md`  
- Controlling: Forecast & Szenarien → `../../controlling/uebersicht.md`

## 8) Beispiel-Output
```text
Optimierungs-Vorschlag: +20% TV, –15% SEA, +10% Social → erwarteter Umsatz +6% bei gleichem Budget
```
