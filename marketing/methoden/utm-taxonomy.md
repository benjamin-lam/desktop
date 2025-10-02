# Methode: UTM-Taxonomy & Governance

**Ziel:** Einheitliche Kampagnen-Kennzeichnung für sauberes Tracking & Attribution.

## 1) Zweck & Nutzen
- Verlässliche Reports (Kanal/Quelle/Kampagne/Content).
- Schnellere Analysen, weniger „unknown“.

## 2) Inputs
- Namenskonventionen, Kanalliste, Kampagnenplan, QA-Prozess.

## 3) Vorgehen
1. Konventionen definieren: `utm_source`, `utm_medium`, `utm_campaign`, `utm_content`, `utm_term`.  
2. Generator/Sheet bereitstellen, QA-Checks.  
3. Monitoring (404/Redirects, Param-Verlust).  
4. Schulung & Review.

## 4) Metriken
- Anteil korrekt getaggter Sessions/Revenue, „unknown“-Quote.

## 5) Grenzen
- Manuelle Fehler; Plattformen entfernen Parameter.

## 6) Checklisten
**DoR:** [ ] Konvention Draft, [ ] Tool/Sheet, [ ] Owner  
**DoD:** [ ] Doku live, [ ] QA aktiv, [ ] Training erfolgt

## 7) Verknüpfungen
- Attribution/MMM: `attribution-models.md`, `mmm-marketing-mix-modelling.md`  
- Controlling: Reports & KPIs → `../../controlling/uebersicht.md`

## 8) Beispiel-Output
```text
Standard: utm_source=meta, utm_medium=paid_social, utm_campaign=fy25_q4_launch_x
QA: daily Check, Unknown < 3%
```
