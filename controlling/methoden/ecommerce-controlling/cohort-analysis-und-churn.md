# Methode: Cohort Analysis & Churn/Retention

**Kategorie:** E-Commerce-Controlling  
**Ziel:** Wiederkaufsverhalten und Bindung über Kohorten verstehen; Churn senken, Retention steigern.  
**Typische Einsatzfälle:** CRM-Strategie, Loyalty-Programme, Lifecycle-Marketing, Kanalbewertung.

---

## 1) Zweck & Business-Nutzen
- Zeigt, **welche Neukundenkohorten** (z. B. Monat/Kanal) gut performen.  
- Identifiziert **Zeitpunkte & Gründe** für Abwanderung (Churn).  
- Grundlage für **Budgetverteilung** und **Retention-Maßnahmen**.

## 2) Daten & Inputs
- Erstkauf-Datum & -Quelle (Kohortenbildung)  
- Wiederkäufe je Periode (M1..M12), AOV, Deckungsbeitrag  
- CRM-Events (E-Mail, Push), Status (aktiv/inaktiv)

## 3) Vorgehen (Schritt für Schritt)
1. Kohorten nach **Erstkaufmonat × Kanal** bilden.  
2. **Retention-Matrix** (Monat t nach Erstkauf: aktiver Anteil, DB/Kunde).  
3. **Churn-Rate** je Periode berechnen; Segment-Treiber analysieren.  
4. Maßnahmen testen (Onboarding, Reaktivierung, Loyalty).

## 4) Formeln & Beispiele
- **Retention(t):** `aktive Kund:innen_t / Startkohorte`  
- **Churn(t):** `1 − Retention(t)`  
- **Beispiel:** Start 10.000; aktiv in M3: 4.100 → Retention 41%, Churn 59%.

## 5) Interpretation & Maßnahmen
- Früher **Retention-Drop** → Onboarding/First-Purchase-Journey verbessern.  
- Später **Retention-Drop** → Sortiment/Preis/Versand, Loyalty anpassen.  
- **Segmentiert** lesen (Kanal, Kategorie, Region).

## 6) Grenzen, Annahmen & typische Fehler
- Kohorten mischen (Äpfel & Birnen).  
- CRM-Einfluss nicht getrennt ausgewertet (Confounder).  
- Nur „Anzahl aktiv“ statt **DB-Beitrag** betrachten.

## 7) Checklisten
**DoR:** [ ] Saubere Neukunden-Definition, [ ] Quelle/Kanal konsistent, [ ] Zeitfenster fixiert  
**DoD:** [ ] Retention-Matrix + DB, [ ] Maßnahmen + Owner, [ ] Review-Plan

## 8) Verknüpfungen
- Verwandt: [Unit Economics (LTV/CAC)](unit-economics-ltv-cac.md), [Attribution](attribution-modelling.md)  
- KPIs: Retention(t), Churn(t), DB/Kunde(t), LTV  
- Tools: SQL/BI, Python, CRM/ESP

## 9) Beispiel-Output
```text
Methode: Cohort & Churn
Zeitraum: Kohorten 01–06/2025
Ergebnis: SEO-Kohorte 03/2025 Retention M6 = 38% (+6pp vs. Avg); Paid Social M1 = 21% (–11pp)
Maßnahmen: Welcome-Flow Paid Social ausbauen (Elisa, 31.10.), Category-Trigger M2/M3 testen (Alex, 15.11.)
Review: 30.11.
```

---

## Verknüpfungen
- **Geschäftsmodelle:** [B2C](../../../business-models/b2c.md), [D2C](../../../business-models/d2c.md), [B2B2C](../../../business-models/b2b2c.md), [P2P](../../../business-models/p2p.md)
- **Zielgruppen:** [Endkund:innen](../../../zielgruppen/endkundinnen.md), [Plattform-User:innen](../../../zielgruppen/plattform-user.md)
- **Vertriebswege:** [Onlineshop](../../../vertriebswege/onlineshop.md), [Mobile Apps](../../../vertriebswege/mobile-apps.md), [Social Commerce](../../../vertriebswege/social-commerce.md), [Marktplatz / Plattform](../../../vertriebswege/marktplatz.md)
- **Erlösmodelle:** [Abonnement](../../../erloesmodelle/abonnement.md), [Direktverkauf](../../../erloesmodelle/direktverkauf.md), [Werbung](../../../erloesmodelle/werbung.md), [Cross-Selling](../../../erloesmodelle/cross-selling.md)
