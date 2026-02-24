---
sprint: 0
goal: "Scoping & Risiko-Setup"
dependencies: []
estimated_duration: "1h"
critical: true
files_changed: []
test_files: []
deliverables:
  - delivery-plan.md
  - risk-register.md
  - test-plan.md
---

# Auto Sorter – Sprint 0: Scoping & Risiko-Setup

## Ziel
Einen belastbaren Delivery-Rahmen für die Weiterentwicklung des Auto Sorters erstellen.

## Inputs
- `README.md` (Projektbeschreibung)
- Bestehender Code in `/app`
- VIP3 Coding Prinzipien (optimierte Version)

---

## Aufgaben

### 1. Scope-Analyse (20 min)

#### Ziel
Definiere **5–8 klare Deliverables** für die nächsten 4 Sprints.

#### Mögliche Bereiche
- **Code-Qualität:** Error Handling, Logging, Type Hints
- **Features:** Batch-Processing, Undo-Funktion, Fortschrittsanzeige
- **Performance:** Caching, asynchrone Verarbeitung
- **Testing:** Unit Tests, Integration Tests, Performance Tests
- **Dokumentation:** API-Docs, Architektur-Diagramme

#### Deliverable
Erstelle `VIP3_COPILOT_OPTIMIZED/sprint-artifacts/sprint-0/delivery-plan.md`:

```markdown
# Delivery Plan – Auto Sorter

## Sprint 1: Stabilität & Error Handling
1. Error Handling in main.py (Try-Catch, Logging)
2. Retry-Logic für ChromaDB (Exponential Backoff)
3. Validierung in text_extractor.py (Leere Dateien)
4. Zentrales Logging-Setup

**Akzeptanzkriterien:**
- Programm stürzt nicht bei defekten Dateien ab
- Tests: pytest tests/test_error_handling.py → grün
- Coverage: >70% für main.py, chroma_client.py

## Sprint 2: Batch-Processing & Undo
[...weitere Sprints...]
```

---

### 2. Risiko-Register (20 min)

#### Ziel
Identifiziere technische und prozessuale Risiken mit Mitigation-Strategien.

#### Format
| Risiko | Wahrscheinlichkeit | Impact | Mitigation |
|--------|-------------------|--------|------------|
| ChromaDB nicht verfügbar beim Start | Hoch | Hoch | Retry-Logic mit Exponential Backoff (Sprint 1) |
| Große Dateien (>100MB) blockieren Processing | Mittel | Hoch | File-Size-Check + Streaming (Sprint 3) |
| Race Condition bei paralleler Verarbeitung | Mittel | Mittel | File-Locking + Queue-System (Sprint 3) |
| Encoding-Fehler bei Non-UTF8-Dateien | Hoch | Niedrig | Try-Catch mit Fallback auf latin-1 (Sprint 1) |
| ChromaDB-Persistenz verloren bei Docker-Restart | Niedrig | Hoch | Volume-Mounts validieren + Backup-Strategie (Sprint 0) |

#### Deliverable
Erstelle `VIP3_COPILOT_OPTIMIZED/sprint-artifacts/sprint-0/risk-register.md`

---

### 3. Test-Strategie (15 min)

#### Ziel
Definiere, wie Features validiert werden.

#### Kategorien

**Unit Tests:**
- Module: `text_extractor.py`, `embedder.py`, `chroma_client.py`, `utils.py`
- Framework: `pytest`
- Coverage-Ziel: 70% für Core-Module
- Ausführung: `pytest tests/unit/`

**Integration Tests:**
- End-to-End-Szenarien:
  1. Datei in Inbox → Embedding → Query → Sortierung
  2. Defekte Datei → landet in `errors/`
  3. Batch-Modus: 5 Dateien → alle sortiert
  4. Undo: Sortierung → Undo → Datei zurück
- Ausführung: `pytest tests/integration/`

**Performance Tests:**
- Embedding-Geschwindigkeit: <2s pro Datei
- Startup-Zeit: <10s mit 100 READMEs
- Query-Zeit: <200ms bei 1000 Dokumenten
- Tool: `pytest-benchmark` oder manuelles Benchmarking

**Manuelle Tests:**
- User-Interaktionen (CLI-Kommandos: j, n, s, u, i)
- Docker-Startup (Health-Checks)
- Cross-Platform (Windows, macOS, Linux)

#### Deliverable
Erstelle `VIP3_COPILOT_OPTIMIZED/sprint-artifacts/sprint-0/test-plan.md`

---

### 4. Sprint-Mapping (5 min)

#### Ziel
Priorisiere Deliverables aus `delivery-plan.md` und ordne sie Sprints zu.

#### Struktur
```markdown
# Sprint Mapping

## Sprint 1: Stabilität (Critical Path)
- Error Handling
- Retry-Logic
- Logging
→ Blockt: Sprint 2, Sprint 3

## Sprint 2: Features (Depends on Sprint 1)
- Batch-Processing
- Undo-Funktion
→ Blockt: Sprint 4

## Sprint 3: Performance (Parallel zu Sprint 2 möglich)
- Caching
- Async Processing
→ Blockt: Keine

## Sprint 4: Testing & Docs (Depends on Sprint 1-3)
- Unit Tests
- Integration Tests
- Dokumentation
→ Blockt: Release
```

#### Deliverable
Ergänze in `delivery-plan.md` eine Sektion "Sprint Mapping"

---
## Definition of Done (DoD)

### Automatisiert testbar
- [ ] Alle 3 Dateien existieren:
  - `sprint-artifacts/sprint-0/delivery-plan.md`
  - `sprint-artifacts/sprint-0/risk-register.md`
  - `sprint-artifacts/sprint-0/test-plan.md`

### Inhaltlich vollständig
- [ ] `delivery-plan.md`:
  - Enthält 5–8 konkrete Deliverables
  - Jedes Deliverable hat Akzeptanzkriterien
  - Sprint-Mapping ist dokumentiert
- [ ] `risk-register.md`:
  - Mindestens 5 Risiken identifiziert
  - Tabelle ist vollständig (alle 4 Spalten gefüllt)
  - Mindestens 3 Risiken haben "Hoch" Impact
- [ ] `test-plan.md`:
  - Unit-, Integration-, Performance-Tests definiert
  - Tools/Frameworks sind benannt
  - Testabdeckung-Ziele sind gesetzt

### Keine Implementierung
- [ ] Dieser Sprint enthält **nur Planung**
- [ ] Keine Code-Änderungen am bestehenden System

---

## Test-Case (Automatisiert)

```python name=sprint-artifacts/sprint-0/tests.py
"""
Automatisierte Tests für Sprint 0
Prüft, ob alle Deliverables existieren und vollständig sind.
"""
import os
import pytest


def test_delivery_plan_exists():
    """Prüfe, ob delivery-plan.md existiert."""
    path = "VIP3_COPILOT_OPTIMIZED/sprint-artifacts/sprint-0/delivery-plan.md"
    assert os.path.exists(path), f"Datei {path} existiert nicht"


def test_delivery_plan_has_sprints():
    """Prüfe, ob delivery-plan.md mindestens 4 Sprints definiert."""
    path = "VIP3_COPILOT_OPTIMIZED/sprint-artifacts/sprint-0/delivery-plan.md"
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Zähle "Sprint" Vorkommen (mindestens 4)
    sprint_count = content.lower().count("sprint ")
    assert sprint_count >= 4, f"Nur {sprint_count} Sprints gefunden, erwartet: >=4"


def test_risk_register_exists():
    """Prüfe, ob risk-register.md existiert."""
    path = "VIP3_COPILOT_OPTIMIZED/sprint-artifacts/sprint-0/risk-register.md"
    assert os.path.exists(path), f"Datei {path} existiert nicht"


def test_risk_register_has_table():
    """Prüfe, ob risk-register.md eine Tabelle enthält."""
    path = "VIP3_COPILOT_OPTIMIZED/sprint-artifacts/sprint-0/risk-register.md"
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Prüfe auf Markdown-Tabelle (|---|---|)
    assert "|" in content, "Keine Tabelle gefunden"
    assert "Risiko" in content, "Spalte 'Risiko' fehlt"
    assert "Wahrscheinlichkeit" in content, "Spalte 'Wahrscheinlichkeit' fehlt"
    assert "Mitigation" in content, "Spalte 'Mitigation' fehlt"


def test_test_plan_exists():
    """Prüfe, ob test-plan.md existiert."""
    path = "VIP3_COPILOT_OPTIMIZED/sprint-artifacts/sprint-0/test-plan.md"
    assert os.path.exists(path), f"Datei {path} existiert nicht"


def test_test_plan_has_categories():
    """Prüfe, ob test-plan.md Unit, Integration, Performance definiert."""
    path = "VIP3_COPILOT_OPTIMIZED/sprint-artifacts/sprint-0/test-plan.md"
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read().lower()
    
    assert "unit" in content, "Unit Tests nicht definiert"
    assert "integration" in content, "Integration Tests nicht definiert"
    assert "performance" in content, "Performance Tests nicht definiert"
```

---

## Scope Boundaries

### ✅ In Scope
- Planung und Dokumentation
- Risiko-Analyse
- Test-Strategie

### ❌ Out of Scope
- Code-Implementierung
- Feature-Entwicklung
- Infrastruktur-Änderungen
- Deployment-Setup

### ⚠️ Grenzfälle
**Frage:** Soll Sprint 0 auch ein Template für zukünftige Sprints erstellen?
- **User-Entscheidung:** Nein, Templates werden on-demand in Sprints 1-4 erstellt

---

## Rollback-Plan

### Bei Partial Fail (1-2 Aufgaben unvollständig)
1. Identifiziere fehlende Datei(en)
2. Ergänze nur diese Datei(en)
3. Re-Run: `pytest sprint-artifacts/sprint-0/tests.py`

### Bei Total Fail (>2 Aufgaben unvollständig)
1. Lösche `sprint-artifacts/sprint-0/`
2. Starte Sprint 0 neu
3. Fokus: Klarere Anforderungen klären

---

## Abnahme

### Pass-Kriterien
- Alle Tests grün: `pytest sprint-artifacts/sprint-0/tests.py`
- Alle 3 Dateien existieren und sind vollständig
- User hat Inhalte geprüft und akzeptiert

### Fail-Strategie
Bei **Fail** bitte angeben:
1. Welche Datei fehlt oder ist unvollständig?
2. Was konkret fehlt in der Datei?
3. Soll ich nachbessern oder Sprint neu starten?

---

## Sprint-Retrospektive (User füllt aus)

### Was lief gut?
- [ ] Aufgaben waren klar formuliert
- [ ] Automatisierte Tests waren hilfreich
- [ ] Zeitschätzung war realistisch
- [ ] Deliverables waren nützlich

### Was lief schlecht?
- [ ] Aufgaben waren zu vage
- [ ] Tests fehlten oder waren falsch
- [ ] Zeitschätzung war unrealistisch
- [ ] Zu viel/zu wenig Output

### Verbesserungen für Sprint 1
(User-Input hier eintragen)

### Prompt-Qualität (1-5 Sterne)
- **Klarheit:** ☐☐☐☐☐
- **Testbarkeit:** ☐☐☐☐☐
- **Umsetzbarkeit:** ☐☐☐☐☐
- **Zeitschätzung:** ☐☐☐☐☐

### Kommentar
(User-Input hier eintragen)

---