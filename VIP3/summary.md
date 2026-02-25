# Auto Sorter – VIP3 Coding Workflow: Initialisierung

## Projektziel
Ein lokal laufendes, KI-gestütztes Dokumenten-Sortierungssystem, das mit semantischer Ähnlichkeit (Embeddings + ChromaDB) Dateien automatisch in eine strukturierte Wissensbasis einordnet und durch User-Feedback lernt.

## Kernfunktionen
1. **File Watcher** – Überwacht `volumes/inbox` kontinuierlich
2. **Text-Extraktion** – PDF, DOCX, TXT, MD, HTML
3. **Embedding-Generierung** – Sentence-Transformers (multilingual)
4. **Semantic Matching** – ChromaDB-Vektorsuche gegen vorhandene READMEs
5. **Interaktive Sortierung** – User bestätigt/korrigiert Vorschläge
6. **Learning-Loop** – Korrekturen fließen in die Wissensbasis ein

## Tech Stack
- **Python 3.11+**
- **Docker + Docker Compose**
- **ChromaDB** (Vektor-Datenbank)
- **Sentence-Transformers** (`paraphrase-multilingual-MiniLM-L12-v2`)
- **PyPDF2, python-docx, BeautifulSoup** (Extraktion)

## Repository-Struktur
```
benjamin-lam/desktop/
├── app/
│   ├── main.py              # Entry-Point & File Watcher
│   ├── embedder.py          # Embedding-Generierung
│   ├── chroma_client.py     # ChromaDB-Client
│   ├── text_extractor.py    # Dokumenten-Parsing
│   ├── utils.py             # Helper-Funktionen
│   ├── Dockerfile
│   └── requirements.txt
├── docker-compose.yml
├── .env.example
└── README.md
```

## Arbeitsweise
Dieser Workflow ist in **Sprints** organisiert. Jeder Sprint:
- Hat ein klares Ziel und Deliverables
- Definiert **Definition of Done (DoD)** mit Pass/Fail-Kriterien
- Wird sequenziell abgearbeitet (kein Überspringen!)
- Endet mit einer User-Entscheidung: **Pass** oder **Fail**

## Nächste Schritte
1. Lies `sprint-0.md`
2. Führe Sprint 0 vollständig aus
3. Warte auf User-Feedback (**Pass**/**Fail**)
4. Erst dann weiter zu Sprint 1

---

**Hinweis für GitHub Copilot:**
- Verwende `benjamin-lam/desktop` als Repository-Kontext
- Alle Python-Code-Änderungen müssen syntaktisch korrekt sein
- Docker-Konfigurationen müssen validiert werden
- Tests sind optional, aber empfohlen
- Commits sollen atomar und nachvollziehbar sein

**STOP! Lese jetzt sprint-0.md.**
````

````markdown name=sprint-0.md
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
````

````markdown name=sprint-1.md
# Auto Sorter – Sprint 1: Stabilität & Error Handling

## Ziel
Das bestehende System robuster machen und grundlegende Error-Handling-Mechanismen implementieren.

## Inputs
- `delivery-plan.md` (aus Sprint 0)
- `app/main.py`, `app/chroma_client.py`, `app/text_extractor.py`

## Aufgaben

### 1. Error Handling in `main.py`
**Problem:** Crashes bei nicht lesbaren Dateien oder ChromaDB-Verbindungsfehlern.

**Lösung:**
- Try-Catch-Blöcke um kritische Operationen (File Reading, DB Queries)
- Graceful Degradation: Bei Fehlern → Datei in `volumes/errors/` verschieben
- Logging mit `logging`-Modul (Level: INFO, WARNING, ERROR)

**Pass-Kriterien:**
- Programm stürzt nicht mehr bei defekten Dateien ab
- Fehlerhafte Dateien werden in `volumes/errors/` verschoben
- Logs enthalten Timestamps und Fehlermeldungen

### 2. Retry-Logic für ChromaDB
**Problem:** ChromaDB ist beim Start manchmal nicht verfügbar.

**Lösung:**
- Exponential Backoff in `chroma_client.py`
- Max. 5 Retry-Versuche mit 2^n Sekunden Wartezeit
- Klare Fehlermeldung nach finalen Retry

**Pass-Kriterien:**
- Script wartet bis zu 32 Sekunden auf ChromaDB
- Bei Erfolg: Normaler Start
- Bei Misserfolg: Sauberer Exit mit Error-Code 1

### 3. Validierung in `text_extractor.py`
**Problem:** Leere oder zu kleine Dateien verursachen Exceptions.

**Lösung:**
- Check: Datei > 10 Bytes
- Check: Extrahierter Text > 20 Zeichen
- Bei Fail: Return `None` statt Exception

**Pass-Kriterien:**
- Keine Exceptions bei leeren/kleinen Dateien
- Logging für übersprungene Dateien
- Unit Test für Edge Cases

### 4. Logging-Konfiguration
**Anforderung:** Strukturiertes Logging in allen Modulen.

**Lösung:**
- Zentrales Logger-Setup in `utils.py`
- Format: `[TIMESTAMP] [LEVEL] [MODULE] – Message`
- Log-Rotation: Max. 10 MB pro File, 3 Backups

**Pass-Kriterien:**
- Alle Module nutzen denselben Logger
- Logs werden in `volumes/logs/app.log` geschrieben
- Alte Logs werden automatisch rotiert

## Definition of Done (DoD)

✅ **Code-Änderungen:**
   - `app/main.py` – Error Handling implementiert
   - `app/chroma_client.py` – Retry-Logic hinzugefügt
   - `app/text_extractor.py` – Validierung eingebaut
   - `app/utils.py` – Logger-Setup erstellt

✅ **Neue Verzeichnisse:**
   - `volumes/errors/` existiert (muss in `docker-compose.yml` gemountet werden)
   - `volumes/logs/` existiert

✅ **Tests:**
   - Manueller Test: Defekte PDF in Inbox → landet in `errors/`
   - Manueller Test: ChromaDB gestoppt → Script wartet/retried
   - Optional: Unit Test für `text_extractor.validate_file()`

✅ **Dokumentation:**
   - `README.md` aktualisiert (Sektion "Fehlerbehandlung")
   - Logging-Format dokumentiert

## Out of Scope
- Feature-Erweiterungen (z.B. neue Dateitypen)
- Performance-Optimierungen
- UI/UX-Verbesserungen

## Abnahme
**Pass:** Alle 4 Aufgaben sind implementiert, Tests bestanden, Dokumentation aktualisiert.  
**Fail:** Mindestens eine Aufgabe ist unvollständig oder Tests schlagen fehl.

Bei **Fail**: Gib an, welche Aufgabe/Test fehlgeschlagen ist.

---

**STOP! Benutzer-Entscheidung abwarten.**
````

````markdown name=sprint-2.md
# Auto Sorter – Sprint 2: Batch-Processing & Undo-Funktion

## Ziel
User Experience verbessern durch Batch-Verarbeitung mehrerer Dateien und eine Undo-Funktion.

## Inputs
- Stabiler Code aus Sprint 1
- `delivery-plan.md` (Sprint 2 Deliverables)

## Aufgaben

### 1. Batch-Processing
**Problem:** Nur eine Datei wird zur Zeit verarbeitet, bei vielen Dateien ist das umständlich.

**Lösung:**
- Beim Start: Alle Dateien in `inbox/` auflisten
- User kann wählen:
  - `b` – Batch-Modus: Alle Dateien automatisch mit Top-Suggestion sortieren
  - `i` – Interaktiver Modus: Jede Datei einzeln bestätigen
- Im Batch-Modus: Fortschrittsanzeige (z.B. `[3/10] Verarbeite dokument.pdf...`)

**Pass-Kriterien:**
- CLI zeigt Batch-Option an
- Batch-Modus verarbeitet alle Dateien automatisch
- Progress wird angezeigt (`tqdm` oder manueller Counter)
- Nach Batch: Summary (`10 sortiert, 2 Fehler`)

### 2. Undo-Funktion
**Problem:** Fehlerhafte Sortierungen können nicht rückgängig gemacht werden.

**Lösung:**
- Protokolliere jede Sortierung in `volumes/history.json`:
  ```json
  {
    "timestamp": "2026-02-24T14:32:10",
    "filename": "dokument.pdf",
    "from": "volumes/inbox",
    "to": "volumes/repo/04_Projekte/AI",
    "user_confirmed": true
  }
  ```
- Neuer CLI-Befehl: `u` – Undo last action
- Bei Undo: Datei zurück in `inbox/` verschieben

**Pass-Kriterien:**
- `history.json` wird bei jeder Sortierung aktualisiert
- `u`-Befehl verschiebt letzte Datei zurück
- Undo ist nur für die letzte Aktion möglich (kein Multi-Undo)

### 3. Interaktiver Fortschritt
**Anforderung:** User sieht während der Verarbeitung, was passiert.

**Lösung:**
- Ausgabe während Embedding-Generierung: `[...] Generiere Embedding...`
- Ausgabe während DB-Query: `[...] Suche ähnliche Dokumente...`
- Bei langsamem Modell: Timeout-Warnung nach 10 Sekunden

**Pass-Kriterien:**
- Jede Phase gibt Status aus
- Bei langsamen Operationen: Hinweis an User

### 4. Error Summary
**Anforderung:** Nach Batch-Processing zeigen, welche Dateien fehlgeschlagen sind.

**Lösung:**
- Sammle Fehler während Batch
- Am Ende: Ausgabe aller fehlerhaften Dateien + Grund
- Optional: `volumes/errors/error-report.txt` erstellen

**Pass-Kriterien:**
- Fehler-Liste wird angezeigt
- Enthält Dateinamen und Fehlergrund

## Definition of Done (DoD)

✅ **Code-Änderungen:**
   - `app/main.py` – Batch-Modus implementiert
   - `app/main.py` – Undo-Funktion implementiert
   - `app/utils.py` – History-Management (JSON Read/Write)

✅ **Neue Dateien:**
   - `volumes/history.json` wird automatisch erstellt

✅ **Tests:**
   - Manueller Test: 5 Dateien in Inbox → Batch-Modus → alle sortiert
   - Manueller Test: Undo → letzte Datei zurück in Inbox
   - Manueller Test: Fehlerhafte Datei im Batch → Error Summary zeigt sie an

✅ **Dokumentation:**
   - `README.md` aktualisiert (Sektion "Batch-Processing & Undo")

## Out of Scope
- Multi-Undo (nur letzte Aktion)
- Redo-Funktion
- GUI/Web-Interface

## Abnahme
**Pass:** Alle 4 Aufgaben sind implementiert, Tests bestanden, Dokumentation aktualisiert.  
**Fail:** Mindestens eine Aufgabe ist unvollständig oder Tests schlagen fehl.

Bei **Fail**: Gib an, welche Aufgabe/Test fehlgeschlagen ist.

---

**STOP! Benutzer-Entscheidung abwarten.**
````

````markdown name=sprint-3.md
# Auto Sorter – Sprint 3: Performance & Caching

## Ziel
System beschleunigen durch Caching von Embeddings und optimierte Datenbank-Queries.

## Inputs
- Code aus Sprint 2
- `test-plan.md` (Performance-Tests)

## Aufgaben

### 1. Embedding-Cache
**Problem:** Embeddings für READMEs werden bei jedem Start neu generiert.

**Lösung:**
- Cache Embeddings in `volumes/cache/embeddings.pkl` (Pickle)
- Key: File-Hash (SHA256)
- Beim Start: Prüfe Cache → nur neue/geänderte Dateien embedden
- Invalidierung: Wenn README geändert wurde (Timestamp-Check)

**Pass-Kriterien:**
- Erster Start: Alle READMEs embedden (wie bisher)
- Zweiter Start: Cache genutzt → 10x schneller
- Geänderte READMEs werden neu geembedded

### 2. ChromaDB-Query-Optimierung
**Problem:** Bei vielen Dokumenten wird die Query langsam.

**Lösung:**
- Limit auf Top 5 Ergebnisse statt Full Scan
- Filter nach Metadata (z.B. nur bestimmte Verzeichnisse)
- Index-Tuning in ChromaDB-Konfiguration

**Pass-Kriterien:**
- Query-Zeit < 200ms bei 1000 Dokumenten
- Benchmark: Vor/Nach-Vergleich dokumentiert

### 3. Asynchrone Datei-Verarbeitung
**Problem:** File Watcher blockiert während Embedding-Generierung.

**Lösung:**
- Nutze `asyncio` oder Threading für Datei-Verarbeitung
- Queue-System: Dateien werden in Queue geschoben, Worker verarbeiten parallel
- Max. 2 parallele Worker (wegen RAM)

**Pass-Kriterien:**
- Neue Dateien werden sofort erkannt (kein Blocking)
- 2 Dateien können parallel verarbeitet werden
- Kein Race-Condition-Bug

### 4. Performance-Monitoring
**Anforderung:** Messe und logge Verarbeitungszeiten.

**Lösung:**
- Decorator `@timeit` für kritische Funktionen
- Logge Zeiten: `[INFO] Embedding generated in 1.2s`
- Optional: Export in `volumes/logs/performance.csv`

**Pass-Kriterien:**
- Alle kritischen Funktionen sind instrumentiert
- Performance-Logs sind lesbar
- CSV enthält Timestamp, Function, Duration

## Definition of Done (DoD)

✅ **Code-Änderungen:**
   - `app/embedder.py` – Cache-Logic implementiert
   - `app/chroma_client.py` – Query-Optimierung
   - `app/main.py` – Asynchrone Verarbeitung (oder Threading)
   - `app/utils.py` – `@timeit` Decorator

✅ **Neue Dateien:**
   - `volumes/cache/embeddings.pkl` wird automatisch erstellt
   - Optional: `volumes/logs/performance.csv`

✅ **Tests:**
   - Benchmark: Startup-Zeit mit Cache vs. ohne Cache
   - Benchmark: Query-Zeit bei 100, 500, 1000 Dokumenten
   - Manueller Test: 2 Dateien gleichzeitig in Inbox → beide werden verarbeitet

✅ **Dokumentation:**
   - `README.md` aktualisiert (Sektion "Performance & Caching")
   - Benchmark-Ergebnisse dokumentiert

## Out of Scope
- Mehr als 2 parallele Worker
- GPU-Beschleunigung für Embeddings
- Verteilte Verarbeitung

## Abnahme
**Pass:** Alle 4 Aufgaben sind implementiert, Benchmarks zeigen Verbesserung, Dokumentation aktualisiert.  
**Fail:** Performance-Ziele nicht erreicht oder Tests schlagen fehl.

Bei **Fail**: Gib an, welche Performance-Metrik nicht erfüllt wurde.

---

**STOP! Benutzer-Entscheidung abwarten.**
````

````markdown name=sprint-4.md
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
````

````markdown name=sprint-5.md
# Auto Sorter – Sprint 5: Polishing & Release-Vorbereitung

## Ziel
Projekt produktionsreif machen: Bugfixes, UX-Verbesserungen, Release-Notes.

## Inputs
- Getesteter Code aus Sprint 4
- User-Feedback aus bisherigen Sprints

## Aufgaben

### 1. CLI-Verbesserungen
**Ziel:** Nutzerfreundlichere Kommandozeile.

**Änderungen:**
- **Help-Befehl:** `h` zeigt alle verfügbaren Kommandos
- **Farbige Ausgabe:** Erfolg = Grün, Fehler = Rot, Warnung = Gelb (z.B. mit `colorama`)
- **Keyboard Shortcuts:** `Ctrl+C` → Graceful Shutdown (keine Datenverluste)
- **Auto-Complete:** Bei Pfad-Eingabe → Tab-Completion für Verzeichnisse

**Pass-Kriterien:**
- Help ist vollständig und übersichtlich
- Farben sind konsistent
- `Ctrl+C` bricht sauber ab (keine Zombie-Prozesse)

### 2. Bugfixes aus Sprint 1-4
**Ziel:** Bekannte Issues beheben.

**Beispiele:**
- Race Condition bei paralleler Datei-Verarbeitung
- Encoding-Fehler bei nicht-UTF8-Dateien
- ChromaDB-Persistenz bei Docker-Restart

**Vorgehen:**
1. Issues aus `risk-register.md` prüfen
2. Reproduzierbare Bugs fixen
3. Regression-Tests hinzufügen

**Pass-Kriterien:**
- Alle kritischen Bugs aus Sprint 1-4 sind behoben
- Neue Tests verhindern Regression

### 3. Release-Notes
**Ziel:** Transparente Kommunikation über Änderungen.

**Inhalte:**
- `CHANGELOG.md` erstellen (Format: Keep a Changelog)
- Versionen: `v0.1.0` (Sprint 0), `v0.2.0` (Sprint 1), ..., `v0.5.0` (Sprint 5)
- Pro Version: Added, Changed, Fixed, Deprecated

**Pass-Kriterien:**
- `CHANGELOG.md` existiert
- Alle Sprints sind dokumentiert
- Format ist konsistent

### 4. Docker-Optimierungen
**Ziel:** Schnellere Builds und kleinere Images.

**Änderungen:**
- Multi-Stage Build in `Dockerfile`
- `.dockerignore` für unnötige Dateien (z.B. `.git`, `tests/`)
- Health-Checks in `docker-compose.yml`

**Pass-Kriterien:**
- Image-Größe < 1 GB
- Build-Zeit < 2 Minuten (auf durchschnittlicher Hardware)
- Health-Checks funktionieren (`docker-compose ps` zeigt "healthy")

## Definition of Done (DoD)

✅ **Code-Änderungen:**
   - `app/main.py` – CLI-Verbesserungen implementiert
   - Bugfixes aus Sprint 1-4 eingepflegt
   - `Dockerfile` optimiert

✅ **Neue Dateien:**
   - `CHANGELOG.md` erstellt
   - `.dockerignore` erstellt

✅ **Tests:**
   - Alle neuen Features manuell getestet
   - Regression-Tests für Bugfixes hinzugefügt
   - Docker Health-Checks getestet

✅ **Dokumentation:**
   - `README.md` aktualisiert (finale Version)
   - Release-Notes in `CHANGELOG.md` vollständig

## Out of Scope
- Deployment auf Cloud-Plattformen
- Web-Interface
- Mobile App

## Abnahme
**Pass:** Alle 4 Aufgaben sind abgeschlossen, keine kritischen Bugs, Dokumentation vollständig.  
**Fail:** Kritische Bugs bestehen oder Dokumentation ist unvollständig.

Bei **Fail**: Gib an, welche Bugs noch offen sind oder was in der Dokumentation fehlt.

---

**STOP! Benutzer-Entscheidung abwarten.**

---

## Nach Sprint 5
Das Projekt ist jetzt **produktionsreif**. Optional:
- **Sprint 6+:** Neue Features (z.B. OCR für gescannte PDFs, Web-Interface)
- **Maintenance:** Regelmäßige Updates, Security-Patches
- **Community:** GitHub Issues, Pull Requests, Contributions

**Gratulation! 🎉**
````

---

## Zusammenfassung

Ich habe dir einen **VIP3-basierten Workflow mit 6 Dateien** erstellt:

1. **init.md** – Projekt-Initialisierung und Kontext
2. **sprint-0.md** – Scoping, Risiken, Testing-Strategie
3. **sprint-1.md** – Stabilität & Error Handling
4. **sprint-2.md** – Batch-Processing & Undo
5. **sprint-3.md** – Performance & Caching
6. **sprint-4.md** – Testing & Dokumentation
7. **sprint-5.md** – Polishing & Release

**Arbeitsweise:**
- Jeder Sprint hat klare **Pass/Fail-Kriterien**
- Nach jedem Sprint **STOP** und auf deine Entscheidung warten
- Keine Vermischung von Sprints (sequenziell abarbeiten)

**Optimiert für mich (GitHub Copilot):**
- Klare Code-Referenzen (`app/main.py`)
- Konkrete Deliverables (keine vagen Aufgaben)
- Testbare Akzeptanzkriterien
- Repository-Kontext (`benjamin-lam/desktop`)
