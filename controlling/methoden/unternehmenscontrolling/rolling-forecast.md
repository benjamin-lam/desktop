# Methode: Rolling Forecast (monatlich/vierteljährlich)

**Kategorie:** Unternehmenscontrolling  
**Ziel:** Dynamische, gleitende Planung statt starrer Jahresbudgets.

---

## 1) Zweck & Business-Nutzen
- Früherkennung von Abweichungen; schnellere Kurskorrekturen.
- Bessere Liquiditäts- & Kapazitätsplanung.

## 2) Daten & Inputs
- Ist-Zahlen (P&L, Cashflow, Pipeline)
- Treiber (Preise, Volumen, Conversion, Personalkapazität)

## 3) Vorgehen (Schritt für Schritt)
1. Forecast-Horizont festlegen (z. B. 12 Monate rolling).  
2. Treibermodelle definieren (Preis × Menge, CAC → Umsatz etc.).  
3. Monatlich aktualisieren (Ist einpflegen, Annahmen refreshen).  
4. Abweichungen erklären & Maßnahmen hinterlegen.

## 4) Formeln & Beispiele
- **Top-down:** Zielumsatz = ∑(Segmentziel)  
- **Bottom-up:** Umsatz = Traffic × Conversion × AOV

## 5) Interpretation & Maßnahmen
- Fokus auf **Treiberänderungen** statt reiner Abweichungszahlen.
- Maßnahmen im Forecast mitplanen (Owner, ETA).

## 6) Grenzen & Fehler
- „Spreadsheet Illusion“: zu viele Annahmen, zu wenig Validierung.
- Unpräzise Treiber → trügerische Genauigkeit.

## 7) Checklisten
**DoR:** [ ] Treibermodell, [ ] Datenaktualität, [ ] Versionierung  
**DoD:** [ ] Delta-Analyse, [ ] Maßnahmen-Backlog, [ ] Kommunikation

## 8) Verknüpfungen
- Verwandt: [Zero-Based Budgeting](zero-based-budgeting.md), [Szenarioanalyse](szenario-und-sensitivitaet.md)  
- KPIs: Forecast Accuracy, MAPE  
- Tools: BI, Python/Excel

## 9) Beispiel-Output
```text
Methode: Rolling Forecast
Zeitraum: 12M rolling, Update 01.10.2025
Ergebnis: Umsatz -6% ggü. Plan, Haupttreiber Conversion -0,3pp
Maßnahmen: PDP-Tests priorisieren (Jamal, 20.10.), Preiserhöhung +2% (Cash, 01.11.)
Review: 01.11.
```
