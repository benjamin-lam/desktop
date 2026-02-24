# Auto Sorter – Sprint 4: Testing & Dokumentation

## Ziel
Code-Qualität absichern durch automatisierte Tests und umfassende Dokumentation.

## Inputs
- Code aus Sprint 3
- `test-plan.md` (aus Sprint 0)

## Aufgaben

### 1. Unit Tests
**Scope:** Teste einzelne Komponenten isoliert.

**Module:**
- `app/text_extractor.py`:
    - Test: PDF-Extraktion
    - Test: DOCX-Extraktion
    - Test: Leere Datei → `None`
    - Test: Zu kleine Datei → `None`
- `app/embedder.py`:
    - Test: Cache Hit
    - Test: Cache Miss
    - Test: Invalidierung bei geänderter Datei
- `app/utils.py`:
    - Test: Logger-Setup
    - Test: History-Management (JSON Read/Write)

**Framework:** `pytest`

**Pass-Kriterien:**
- Alle Tests laufen durch (`pytest app/tests/`)
- Code Coverage: Mindestens 70% für Core-Module
- Tests sind deterministisch (keine Flaky Tests)

### 2. Integration Tests
**Scope:** End-to-End-Szenarien.

**Szenarien:**
1. **Happy Path:** Datei in Inbox → Embedding → Query → Sortierung
2. **Error Path:** Defekte Datei → landet in `errors/`
3. **Batch Mode:** 5 Dateien → alle sortiert
4. **Undo:** Sortierung → Undo → Datei zurück in Inbox

**Pass-Kriterien:**
- Alle 4 Szenarien laufen in Docker-Umgebung durch
- Tests sind idempotent (können mehrfach ausgeführt werden)
- Test-Daten in `app/tests/fixtures/`

### 3. Performance Tests
**Scope:** Messe Verarbeitungszeiten unter Last.

**Szenarien:**
- 100 Dateien in Inbox → Batch-Verarbeitung
- 1000 READMEs in `repo/` → Startup-Zeit
- Query-Zeit bei 5000 Dokumenten in ChromaDB

**Tool:** Manuelles Benchmarking oder `pytest-benchmark`

**Pass-Kriterien:**
- Dokumentierte Baseline-Werte
- Keine Regression gegenüber Sprint 3

### 4. Dokumentation
**Scope:** Umfassende README und Code-Kommentare.

**Inhalte:**
- **Architektur-Diagramm:** Komponenten + Datenfluss (Mermaid oder ASCII)
- **API-Docs:** Docstrings für alle Funktionen (Google-Style)
- **Troubleshooting:** Erweiterte FAQ (z.B. "ChromaDB startet nicht", "Modell lädt nicht")
- **Development Guide:** Setup für Entwickler, Testing-Workflow

**Pass-Kriterien:**
- README enthält alle Sektionen
- Docstrings sind vollständig (`pydocstyle`-konform)
- Diagramm ist lesbar und korrekt

## Definition of Done (DoD)

✅ **Tests implementiert:**
- `app/tests/test_text_extractor.py` – Mindestens 4 Tests
- `app/tests/test_embedder.py` – Mindestens 3 Tests
- `app/tests/test_utils.py` – Mindestens 2 Tests
- `app/tests/test_integration.py` – Alle 4 Szenarien

✅ **Test-Ausführung:**
- `pytest` läuft ohne Fehler durch
- Coverage-Report zeigt > 70% für Core-Module

✅ **Performance-Tests:**
- Benchmark-Ergebnisse dokumentiert (z.B. in `PERFORMANCE.md`)

✅ **Dokumentation:**
- README enthält Architektur-Diagramm
- README enthält Development Guide
- README enthält erweiterte FAQ
- Alle Funktionen haben Docstrings

## Out of Scope
- 100% Code Coverage
- Load Testing mit externen Tools
- Automatisierte Deployment-Pipeline

## Abnahme
**Pass:** Alle Tests laufen durch, Coverage-Ziel erreicht, Dokumentation vollständig.  
**Fail:** Tests schlagen fehl oder Dokumentation ist unvollständig.

Bei **Fail**: Gib an, welcher Test fehlgeschlagen ist oder welche Dokumentation fehlt.

---

**STOP! Benutzer-Entscheidung abwarten.**