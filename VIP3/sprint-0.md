# Auto Sorter – Sprint 0: Scoping & Risiko-Setup

## Ziel
Einen belastbaren Delivery-Rahmen für die Weiterentwicklung des Auto Sorters erstellen.

## Inputs
- `README.md` (Projektbeschreibung)
- Bestehender Code in `/app`
- VIP3 Coding Prinzipien

## Aufgaben

### 1. Scope-Analyse
Analysiere den bestehenden Code und definiere **5–8 klare Deliverables** für die nächsten 4 Sprints.

**Mögliche Bereiche:**
- Code-Qualität (Error Handling, Logging)
- Feature-Erweiterungen (Batch-Processing, Undo-Funktion)
- Performance (Caching, asynchrone Verarbeitung)
- User Experience (CLI-Verbesserungen, Fortschrittsanzeige)
- Testing (Unit Tests, Integration Tests)
- Dokumentation (API-Docs, Architektur-Diagramme)

**Erstelle:** `delivery-plan.md`

### 2. Risiko-Register
Identifiziere technische und prozessuale Risiken:
- Abhängigkeiten (Docker, ChromaDB, Sentence-Transformers)
- Performance-Bottlenecks (große Dateien, langsame Embeddings)
- Datenintegrität (ChromaDB-Persistenz, Race Conditions)
- User Experience (Fehlende Feedback-Mechanismen)

**Format:**
| Risiko | Wahrscheinlichkeit | Impact | Mitigation |
|--------|-------------------|--------|------------|
| ... | Hoch/Mittel/Niedrig | Hoch/Mittel/Niedrig | Konkrete Maßnahme |

**Erstelle:** `risk-register.md`

### 3. Test-Strategie
Definiere, wie Features validiert werden:
- **Unit Tests:** Welche Komponenten? (z.B. `text_extractor.py`, `embedder.py`)
- **Integration Tests:** End-to-End-Szenarien (z.B. Datei → Inbox → Sortierung)
- **Manuelle Tests:** User-Interaktionen (CLI-Kommandos)
- **Performance Tests:** Embedding-Geschwindigkeit, Datenbank-Queries

**Erstelle:** `test-plan.md`

### 4. Sprint-Reihenfolge
Priorisiere die Deliverables aus `delivery-plan.md`:
- Sprint 1: Grundlagen / Stabilität
- Sprint 2: Core Features
- Sprint 3: Performance / UX
- Sprint 4: Testing / Dokumentation

**Ergänze in:** `delivery-plan.md` (Sektion "Sprint Mapping")

## Definition of Done (DoD)

✅ **Datei erstellt:** `delivery-plan.md`
- Enthält 5–8 konkrete Deliverables
- Jedes Deliverable hat klare Akzeptanzkriterien
- Sprint-Zuordnung ist dokumentiert

✅ **Datei erstellt:** `risk-register.md`
- Mindestens 5 Risiken identifiziert
- Jedes Risiko hat Wahrscheinlichkeit, Impact und Mitigation
- Tabelle ist vollständig gefüllt

✅ **Datei erstellt:** `test-plan.md`
- Unit-, Integration- und Performance-Tests sind definiert
- Tools/Frameworks sind benannt (z.B. `pytest`, `locust`)
- Testabdeckung-Ziele sind gesetzt (z.B. 70% für Core-Module)

✅ **Keine Implementierung**
- Dieser Sprint enthält **nur Planung**, keine Code-Änderungen

## Out of Scope
- Code-Änderungen am bestehenden System
- Feature-Implementierung
- Infrastruktur-Anpassungen

## Abnahme
**Pass:** Alle 3 Dateien existieren und erfüllen die DoD-Kriterien.  
**Fail:** Mindestens eine Datei fehlt oder ist unvollständig.

Bei **Fail**: Gib stichpunktartig an, was fehlt.

---

**STOP! Benutzer-Entscheidung abwarten.**