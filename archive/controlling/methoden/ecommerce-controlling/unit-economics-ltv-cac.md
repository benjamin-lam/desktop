# Methode: Unit Economics (LTV / CAC)

**Kategorie:** E-Commerce-Controlling  
**Ziel:** Nachhaltigkeit des Wachstums bewerten (Kund:innenwert vs. Akquisekosten).

---

## 1) Zweck & Business-Nutzen
- Entscheiden, welche Kanäle/Segmente profitabel skalieren.
- Budgetallokation & Bid-Strategie faktenbasiert steuern.

## 2) Daten & Inputs
- CAC je Kanal/Kampagne (Marketingkosten / gewonnene Neukund:innen)
- LTV (Deckungsbeitrag über Lebenszeit; Kohortenbasiert)
- DB je Bestellung, Retourenquoten, Payment/Versand

## 3) Vorgehen (Schritt für Schritt)
1. Kohorten definieren (Monat/Quelle/Region).  
2. CAC je Kohorte ermitteln.  
3. LTV je Kohorte über Zeit (t+3/6/12) aggregieren.  
4. **LTV/CAC** und **Payback-Periode** berechnen.

## 4) Formeln & Beispiele
- **CAC:** `CAC = Marketingkosten / #Neukund:innen`  
- **LTV (vereinfachte Näherung):** `LTV = ∑(DB_t * Retention_t) / (1 + r)^t`  
- **Daumenregel:** LTV/CAC ≥ 3, Payback ≤ 12 Monate (je nach Modell).

## 5) Interpretation & Maßnahmen
- LTV/CAC < 1: Kanal stoppen/umbauen; Landingpages/Onboarding optimieren.
- Kurze Payback-Zeit = schnelleres Reinvestitionspotenzial.

## 6) Grenzen & Fehler
- Überschätzung von LTV (Optimismus, fehlende Kosten).
- Kohorten-Mix verschiebt Durchschnitt – immer segmentiert lesen.

## 7) Checklisten
**DoR:** [ ] Kohortenlogik, [ ] saubere Neukunden-Definition, [ ] DB-Logik inkl. Retouren  
**DoD:** [ ] LTV/CAC je Kohorte, [ ] Maßnahmen-Board, [ ] Review-Termin

## 8) Verknüpfungen
- Verwandt: [Cohort Analysis](cohort-analysis-und-churn.md), [Attribution](attribution-modelling.md)  
- KPIs: LTV, CAC, Payback, DB je Bestellung  
- Tools: SQL/BI, Python, GA4, Attribution-Tools

## 9) Beispiel-Output
```text
Methode: Unit Economics (LTV/CAC)
Zeitraum: Kohorten 01–06/2025
Ergebnis: Meta CAC 42 €, LTV12 138 € → LTV/CAC = 3,3 (OK); TikTok LTV/CAC = 1,7 (Achtung)
Maßnahmen: TikTok Landingpage & Creative testen (Elisa, 31.10.), E-Mail Onboarding erweitern (Alex, 15.11.)
Review: 30.11.
```
