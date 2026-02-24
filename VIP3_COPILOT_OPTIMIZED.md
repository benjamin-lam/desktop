# VIP3 Coding Workflow – Optimiert für GitHub Copilot

## 1. Beschreibung der Methode

### Was ist VIP3 Coding?
VIP3 (Verified Iterative Prompt-based Programming Protocol) ist eine agile Entwicklungsmethode für KI-assistierte Codierung. Der Workflow basiert auf:

- **Iterative Sprints:** Kleine, abgeschlossene Arbeitseinheiten
- **Pass/Fail-Entscheidungen:** Klare Qualitätskontrolle nach jedem Sprint
- **Definition of Done (DoD):** Messbare Akzeptanzkriterien
- **Sequenzielle Ausführung:** Keine parallelen Sprints, klare Abhängigkeiten
- **Deterministische Deliverables:** Konkrete Ergebnisse statt vager Ziele

### Workflow-Struktur
```
init.md          → Projekt-Kontext & Ziele
sprint-0.md      → Scoping & Risiko-Analyse
sprint-1.md      → Feature/Bugfix-Implementierung
sprint-2.md      → Weitere Iteration
...              → Weitere Sprints
sprint-n.md      → Abschluss & Release
```

### Typischer Sprint-Ablauf
1. **User liest Sprint-Datei** (z.B. `sprint-1.md`)
2. **Copilot führt Aufgaben aus** (Code-Änderungen, Tests, Dokumentation)
3. **User prüft Ergebnis** (manuell oder automatisiert)
4. **User entscheidet:** `Pass` → nächster Sprint | `Fail` → Nachbesserung
5. **STOP:** Warten auf User-Feedback, bevor es weitergeht

---

## 2. Was funktioniert besser – aus Copilot-Perspektive

### ✅ Was bereits gut funktioniert

#### 2.1 Klare Struktur mit Pass/Fail-Kriterien
**Warum gut:**
- Gibt mir eindeutige Erfolgskriterien
- Verhindert Scope Creep (keine schleichende Feature-Erweiterung)
- User kann objektiv bewerten

**Beispiel:**
```markdown
## Definition of Done (DoD)
✅ Datei `delivery-plan.md` existiert
✅ Enthält 5–8 konkrete Deliverables
✅ Jedes Deliverable hat Akzeptanzkriterien
```

#### 2.2 Sequenzielle Sprints mit STOP
**Warum gut:**
- Verhindert, dass ich zu weit voraus plane (ich neige dazu, alles auf einmal zu lösen)
- User behält Kontrolle über die Richtung
- Feedback-Loop wird erzwungen

#### 2.3 Konkrete Code-Referenzen
**Warum gut:**
- Ich kann direkt auf Dateien zugreifen (`app/main.py`)
- Weniger Interpretationsspielraum
- Schnellere Tool-Calls (ich weiß, wo ich suchen muss)

---

### 🚀 Was ich anders/besser machen würde

#### 2.4 Problem: Zu viel Text in Sprint-Dateien
**Aktuell:**
Sprint-Dateien enthalten viel Kontext-Wiederholung (Inputs, Out of Scope, Abnahme).

**Besser:**
- **Template-basierte Sprints:** Nur Unterschiede zum Template definieren
- **Metadaten-Block:** Maschinenlesbare Struktur am Anfang

**Beispiel:**
```yaml
---
sprint: 1
goal: "Stabilität & Error Handling"
dependencies: ["sprint-0"]
estimated_duration: 2h
critical: true
---

## Aufgaben
1. Error Handling in `main.py`
   - Try-Catch um File Reading
   - Logging mit `logging`-Modul
   - **Pass:** Programm stürzt nicht bei defekten Dateien ab
```

**Warum besser:**
- Ich kann Metadaten direkt parsen (Dependencies, Duration)
- Weniger Text → schnellere Verarbeitung
- YAML ist strukturiert → besser für Tooling

---

#### 2.5 Problem: Manuelle Tests sind nicht deterministisch
**Aktuell:**
```markdown
✅ Tests:
   - Manueller Test: Defekte PDF in Inbox → landet in `errors/`
```

**Besser:**
- **Automatisierte Tests als Teil des Sprints**
- Test-Code direkt in Sprint-Datei als Code-Block

**Beispiel:**
````markdown
## Aufgabe 1: Error Handling

**Test-Case:**
```python name=test_error_handling.py
import pytest
from app.main import process_file

def test_defective_pdf_moves_to_errors():
    # Given: Defekte PDF in Inbox
    defective_pdf = "tests/fixtures/broken.pdf"
    
    # When: Verarbeitung
    result = process_file(defective_pdf)
    
    # Then: Datei in errors/
    assert result.status == "error"
    assert os.path.exists("volumes/errors/broken.pdf")
```

**DoD:** `pytest tests/test_error_handling.py` läuft grün
````

**Warum besser:**
- Ich kann Tests direkt ausführen (mit `githubwrite` + pytest)
- User muss nicht manuell testen
- Deterministisch: Test ist entweder grün oder rot

---

#### 2.6 Problem: Out of Scope ist zu generisch
**Aktuell:**
```markdown
## Out of Scope
- Feature-Erweiterungen
- Performance-Optimierungen
```

**Besser:**
- **Anti-Patterns definieren:** Was explizit NICHT tun
- **Boundary Cases:** Was ist grenzwertig

**Beispiel:**
```markdown
## Scope Boundaries

### ✅ In Scope
- Error Handling für bekannte Dateitypen (PDF, DOCX, TXT)
- Logging mit Python `logging`-Modul

### ❌ Out of Scope
- Neue Dateitypen (z.B. Excel, PowerPoint)
- Strukturiertes Logging (z.B. JSON-Format)
- Externes Monitoring (z.B. Sentry)

### ⚠️ Grenzfälle (User entscheidet)
- Error Handling für Netzwerk-Fehler (ChromaDB down)
  → **Entscheidung:** Ja, mit Retry-Logic (Sprint 1, Aufgabe 2)
```

**Warum besser:**
- Ich weiß genau, was tabu ist
- Grenzfälle werden explizit diskutiert
- Verhindert, dass ich zu viel mache

---

#### 2.7 Problem: Dependencies zwischen Sprints sind implizit
**Aktuell:**
```markdown
## Inputs
- Code aus Sprint 2
```

**Besser:**
- **Explizite Dependency-Deklaration**
- Versionierung der Deliverables

**Beispiel:**
```yaml
---
sprint: 3
dependencies:
  - sprint: 2
    deliverables:
      - "app/main.py (v0.2.0)"
      - "volumes/history.json (Schema v1)"
required_files:
  - app/main.py
  - app/embedder.py
blocks: []  # Keine anderen Sprints blockiert
---
```

**Warum besser:**
- Ich kann automatisch prüfen, ob Dependencies erfüllt sind
- User kann Sprints parallel vorbereiten (z.B. Sprint 3 schreiben, während Sprint 2 läuft)
- Bessere Nachvollziehbarkeit (welcher Sprint ändert was)

---

#### 2.8 Problem: Keine Rollback-Strategie bei Fail
**Aktuell:**
```markdown
**Fail:** Mindestens eine Aufgabe ist unvollständig.\nBei **Fail**: Gib an, welche Aufgabe fehlgeschlagen ist.
```

**Besser:**
- **Rollback-Plan:** Was passiert bei Fail?
- Atomic Commits: Jede Aufgabe = 1 Commit

**Beispiel:**
```markdown
## Abnahme

### Pass-Kriterien
Alle 4 Aufgaben abgeschlossen, alle Tests grün.

### Fail-Strategie
1. **Partial Fail (1-2 Aufgaben unvollständig):**
   - Rollback: `git reset --hard sprint-1-start`
   - Nachbesserung: Fokus auf fehlgeschlagene Aufgaben
   - Re-Test: Nur betroffene Tests

2. **Total Fail (>2 Aufgaben unvollständig):**
   - Rollback: Komplett zu Sprint 0
   - Re-Planning: Sprint-Scope überdenken

### Commit-Strategie
- Jede Aufgabe = 1 Commit (z.B. `feat(sprint-1): add error handling to main.py`)
- Bei Fail: Einzelne Commits reverten
```

**Warum besser:**
- User weiß, wie er mit Fehlern umgeht
- Ich kann atomic arbeiten (1 Aufgabe = 1 Commit)
- Schnellere Nachbesserung (nur kaputtes zurücksetzen)

---

#### 2.9 Problem: Keine Schätzungen für Sprint-Dauer
**Aktuell:**
Sprints haben keine Zeitangaben.

**Besser:**
- **Zeitschätzung pro Aufgabe**
- Gesamtdauer pro Sprint

**Beispiel:**
```markdown
## Aufgaben

### 1. Error Handling in `main.py` (30 min)
- Try-Catch-Blöcke (15 min)
- Logging-Setup (10 min)
- Manuelle Tests (5 min)

### 2. Retry-Logic für ChromaDB (20 min)
- Exponential Backoff (15 min)
- Tests (5 min)

---

**Geschätzte Sprint-Dauer:** 1.5 Stunden  
**Kritischer Pfad:** Aufgabe 1 → Aufgabe 3 (Error Handling muss vor Logging stehen)
```

**Warum besser:**
- User kann besser planen
- Ich kann priorisieren (kritischer Pfad zuerst)
- Realistische Erwartungen (nicht "mach mal alles")

---

#### 2.10 Problem: Kein Feedback-Loop für Sprint-Qualität
**Aktuell:**
User sagt nur Pass/Fail, aber nicht warum.

**Besser:**
- **Sprint-Retrospektive**
- Feedback zu Prompt-Qualität

**Beispiel:**
```markdown
## Sprint-Retrospektive (User füllt aus)

### Was lief gut?
- [ ] Aufgaben waren klar formuliert
- [ ] Tests waren hilfreich
- [ ] Dokumentation war ausreichend

### Was lief schlecht?
- [ ] Aufgaben waren zu vage
- [ ] Tests fehlten
- [ ] Zu viel auf einmal

### Verbesserungen für nächsten Sprint
- (User-Input)

### Prompt-Qualität (1-5 Sterne)
Klarheit: ⭐⭐⭐⭐⭐  
Testbarkeit: ⭐⭐⭐⭐☆  
Umsetzbarkeit: ⭐⭐⭐⭐⭐
```

**Warum besser:**
- User reflektiert über Sprint-Qualität
- Ich lerne, bessere Prompts zu schreiben
- Kontinuierliche Verbesserung des Workflows

---

## 3. Zusammenfassung: Optimaler VIP3-Workflow für Copilot

### Struktur
```
📁 project-root/
├── 📄 init.md                    # Projekt-Kontext
├── 📄 sprint-0.md                # Scoping
├── 📄 sprint-1.md                # Feature-Sprint
│   ├── Metadaten (YAML)
│   ├── Aufgaben (mit Test-Code)
│   ├── DoD (automatisiert testbar)
│   ├── Rollback-Plan
│   └── Retrospektive
├── 📄 sprint-template.md         # Wiederverwendbare Struktur
└── 📁 sprint-artifacts/
    ├── sprint-1-tests.py
    ├── sprint-1-commits.log
    └── sprint-1-retrospective.md
```

### Ideale Sprint-Datei (Template)
```yaml
---
sprint: N
goal: "Kurze Beschreibung"
dependencies: ["sprint-N-1"]
iestimated_duration: "2h"
critical: true/false
---

## Aufgaben

### 1. Aufgabe (Zeitschätzung)
**Ziel:** Was wird erreicht

**Implementierung:**
- Schritt 1
- Schritt 2

**Test-Case:**
```python
# Automatisierter Test
```

**Pass-Kriterium:** Messbares Ergebnis

---

## Definition of Done
- [ ] Code-Änderungen abgeschlossen
- [ ] Tests laufen grün (`pytest`)
- [ ] Dokumentation aktualisiert
- [ ] Commit mit Message `feat(sprint-N): ...`

## Rollback-Plan
- Partial Fail: `git revert <commit>`
- Total Fail: `git reset --hard sprint-N-start`

## Retrospektive
(User füllt nach Pass/Fail aus)
```

---

## 4. Wichtigste Verbesserungen auf einen Blick

| # | Verbesserung | Vorteil für Copilot | Vorteil für User |
|---|-------------|---------------------|------------------|
| 1 | **YAML-Metadaten** | Strukturierte Daten parsbar | Bessere Tool-Integration |
| 2 | **Inline Test-Code** | Kann Tests direkt ausführen | Keine manuelle Testarbeit |
| 3 | **Explizite Dependencies** | Kann Reihenfolge validieren | Parallelisierung möglich |
| 4 | **Rollback-Strategie** | Atomic Commits möglich | Schnelle Fehlerkorrektur |
| 5 | **Zeitschätzungen** | Kann priorisieren | Realistische Planung |
| 6 | **Anti-Patterns (Out of Scope)** | Weiß, was tabu ist | Verhindert Overengineering |
| 7 | **Sprint-Retrospektive** | Lerne bessere Prompts | Kontinuierliche Verbesserung |

---

## 5. Nächste Schritte

### Für dich als User
1. **Wähle einen Ansatz:**
   - **Klassisch:** Nutze die erstellten Sprint-Dateien wie sie sind
   - **Optimiert:** Ergänze Metadaten + Test-Code + Retrospektiven

2. **Starte mit Sprint 0:**
   - Lass mich `delivery-plan.md`, `risk-register.md`, `test-plan.md` erstellen
   - Prüfe Ergebnisse
   - Entscheide: Pass/Fail

3. **Iteriere:**
   - Pro Sprint: Ausführen → Prüfen → Feedback
   - Retrospektive ausfüllen
   - Workflow anpassen

### Für mich als Copilot
- Ich kann beide Ansätze umsetzen
- Bei optimiertem Workflow: Schnellere, deterministischere Ergebnisse
- Bei klassischem Workflow: Mehr manuelles Testen nötig

---

## 6. Beispiel: Optimierter Sprint 1

```yaml
---
sprint: 1
goal: "Stabilität & Error Handling"
dependencies: ["sprint-0"]
estimated_duration: "1.5h"
critical: true
files_changed:
  - app/main.py
  - app/chroma_client.py
  - app/utils.py
test_files:
  - tests/test_error_handling.py
---

## Aufgabe 1: Error Handling in `main.py` (30 min)

### Implementierung
- Try-Catch um `process_file()`
- Fehlerhafte Dateien → `volumes/errors/`
- Logging mit `logging.error()`

### Test
```python name=tests/test_error_handling.py
def test_broken_file_moves_to_errors():
    result = process_file("fixtures/broken.pdf")
    assert result.status == "error"
    assert os.path.exists("volumes/errors/broken.pdf")
```

### DoD
- [ ] `pytest tests/test_error_handling.py` → grün
- [ ] Commit: `feat(sprint-1): add error handling for file processing`

---

## Rollback
- Fail: `git revert HEAD`
- Neu-Versuch: Fokus auf Try-Catch-Logic

## Retrospektive
Klarheit: ☐☐☐☐☐  
Testbarkeit: ☐☐☐☐☐  
Kommentar: ___________
```

---

## Fazit

**VIP3 ist bereits gut strukturiert**, aber kann für mich als Copilot noch **deterministischer** und **testbarer** werden. Die größten Hebel:

1. **Maschinenlesbare Metadaten** (YAML)
2. **Inline-Tests** statt manueller Prüfung
3. **Explizite Dependencies** und Rollback-Pläne
4. **Kontinuierliches Feedback** durch Retrospektiven

Mit diesen Anpassungen wird der Workflow **schneller**, **zuverlässiger** und **skalierbarer** – perfekt für größere Projekte! 🚀
