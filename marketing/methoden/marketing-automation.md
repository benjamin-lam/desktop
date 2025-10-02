# Methode: Marketing Automation

**Ziel:** Skalierte, personalisierte Journeys entlang des Customer Lifecycle.

## 1) Zweck & Nutzen
- Höhere Relevanz, bessere Retention, effizientere Teams.

## 2) Inputs
- Events (Signups, Käufe, Engagement), Profile, Scoring.

## 3) Vorgehen
1. Trigger/Events & Data Contracts definieren.  
2. Journeys modellieren (Onboarding, Cross-/Upsell, Winback).  
3. Branching/Scoring, Throttling & Guardrails.  
4. QA/Monitoring, Holdouts, Iteration.

## 4) Metriken
- Flow-Umsatz, Lift vs. Holdout, Time-to-Value, Churn-Impact.

## 5) Grenzen
- Datenqualität, Consent/Deliverability, Over-Automation.

## 6) Checklisten
**DoR:** [ ] Event-Spez, [ ] Templates, [ ] Holdout-Design  
**DoD:** [ ] Monitoring Dashboards, [ ] Iterationsplan

## 7) Verknüpfungen
- E-Mail/CRM: `email-crm-lifecycle.md`  
- UTM/Attribution: `utm-taxonomy.md`, `attribution-models.md`  
- Controlling: Cohorts/Churn → `../../controlling/methoden/ecommerce-controlling/cohort-analysis-und-churn.md`

## 8) Beispiel-Output
```text
Journey „First 30 Days“: 6 Steps, Lift +11% First-Purchase (Holdout)
Next: Branch für High-Value-Segment
```
