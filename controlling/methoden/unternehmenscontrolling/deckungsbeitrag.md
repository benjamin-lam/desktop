# Methode: Deckungsbeitrag (DB I–III)

**Kategorie:** Unternehmenscontrolling  
**Ziel:** Ermitteln, welchen Beitrag Produkte/Projekte zur Deckung fixer Kosten und zum Gewinn leisten.  
**Typische Einsatzfälle:** Preisgestaltung, Sortimentsbereinigung, Priorisierung von Projekten.

---

## 1) Zweck & Business-Nutzen
- Sichtbar machen, welche Leistungen profitabel sind – auch bei gleichem Umsatz.
- Grundlage für **Make-or-Buy**, **Preisuntergrenzen**, **Kampagnen-Aussteuerung**.

## 2) Daten & Inputs
- Umsätze je Produkt/Projekt
- Variable Kosten (EK, Versand, Zahlungsgebühren, variable Marketingkosten)
- Fixkosten (für DB II/III zuordnen/verteilen)

## 3) Vorgehen (Schritt für Schritt)
1. Variable Kosten pro Einheit konsolidieren.  
2. DB I = Umsatz − variable Kosten.  
3. DB II = DB I − produkt-/bereichsfixe Kosten.  
4. DB III = DB II − unternehmensfixe Kosten (≈ Betriebsergebnis).

## 4) Formeln & Beispiele
- **DB I (Stück):** `DB1 = Preis − variable Kosten`  
- **Beispiel:** Preis 100 €, var. Kosten 60 € → DB1 = 40 €.

## 5) Interpretation & Maßnahmen
- **DB1 > 0:** wirtschaftlich sinnvoll; optimieren (Preis, Kosten, Mix).
- **DB1 < 0:** rausnehmen, redesignen oder Preis/Kosten neu verhandeln.

## 6) Grenzen, Annahmen & typische Fehler
- Falsche Einstufung „variabel vs. fix“.  
- Verdeckte Kosten (z. B. Retouren, Payment-Fees) vergessen.

## 7) Checklisten
**DoR:** [ ] Daten je SKU/Projekt, [ ] Kostenmapping klar, [ ] Zeitraum fixiert  
**DoD:** [ ] DB-Report versioniert, [ ] Maßnahmen + Owner, [ ] Review-Termin

## 8) Verknüpfungen
- Verwandt: [Prozesskostenrechnung / ABC](prozesskostenrechnung-abc.md), [Szenarioanalyse](szenario-und-sensitivitaet.md)  
- KPIs: Bruttomarge, DB-Quote, EBIT  
- Tools: SQL/BI, Excel

## 9) Beispiel-Output (Vorlage)
```text
Methode: Deckungsbeitrag
Zeitraum: Q1/2025
Datengrundlage: ERP v2025-03, Export 2025-04-01
Ergebnis: 18% der SKUs sind negativ profitabel → Maßnahmen fokussieren auf 42 SKUs.
Top-Treiber:
1) Versandkosten > Ziel
2) Zahlungsgebühren hoch
3) Rabattmix ungünstig
Maßnahmen: Versandtarife neu verhandeln (Alex, 15.10.), Zahlungsanbieter B testen (Nina, 31.10.)
Review: 30.11.
```
