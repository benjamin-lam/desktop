# Auto Sorter – VIP3 Optimized: Initialisierung

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
├── README.md
└── VIP3_COPILOT_OPTIMIZED/  # Dieser Workflow
    ├── init.md              # Diese Datei
    ├── sprint-0.md          # Scoping
    ├── sprint-1.md          # Stabilität
    └── sprint-artifacts/    # Deliverables
```

## VIP3 Optimized Workflow

### Was ist anders?
Dies ist die **optimierte Version** des VIP3 Workflows mit:
- ✅ **YAML-Metadaten** für maschinenlesbare Sprint-Infos
- ✅ **Automatisierte Tests** mit pytest (inline in Sprints)
- ✅ **Explizite Dependencies** zwischen Sprints
- ✅ **Rollback-Pläne** bei Fail (Partial/Total)
- ✅ **Zeitschätzungen** pro Aufgabe
- ✅ **Sprint-Retrospektiven** für Feedback-Loop

### Arbeitsweise
1. **Sprint-Datei lesen** (z.B. `sprint-0.md`)
2. **Copilot führt Aufgaben aus** (Code, Tests, Docs)
3. **Tests laufen** (`pytest sprint-artifacts/sprint-N/tests.py`)
4. **User entscheidet:** Pass/Fail
5. **Retrospektive ausfüllen** (Feedback für nächsten Sprint)
6. **STOP** – Nächster Sprint nur nach Pass

### Sprint-Struktur
Jeder Sprint hat:
```yaml
---
sprint: N
goal: "Kurzbeschreibung"
dependencies: ["sprint-N-1"]
estimated_duration: "2h"
critical: true/false
---

## Aufgaben
1. Aufgabe (Zeitschätzung)
   - Implementierung
   - Test (inline Code)
   - Pass-Kriterium

## Definition of Done
- [ ] Code geändert
- [ ] Tests grün
- [ ] Dokumentation aktualisiert

## Rollback-Plan
- Partial Fail: git revert
- Total Fail: git reset

## Retrospektive
- Was lief gut?
- Was lief schlecht?
- Prompt-Qualität (1-5 ⭐)
```

## Nächste Schritte

### 1. Lies Sprint 0
```bash
cat VIP3_COPILOT_OPTIMIZED/sprint-0.md
```

**Sprint 0 Ziel:**
- Delivery-Plan erstellen (5-8 Deliverables)
- Risiko-Register (technische + prozessuale Risiken)
- Test-Plan (Unit, Integration, Performance)

**Geschätzte Dauer:** 1 Stunde

### 2. Starte Sprint 0
In GitHub Chat sagen:
```
Führe Sprint 0 aus
```

Copilot wird:
1. `sprint-artifacts/sprint-0/delivery-plan.md` erstellen
2. `sprint-artifacts/sprint-0/risk-register.md` erstellen
3. `sprint-artifacts/sprint-0/test-plan.md` erstellen
4. `sprint-artifacts/sprint-0/tests.py` erstellen (automatisierte Validierung)

### 3. Tests ausführen
```bash
pytest VIP3_COPILOT_OPTIMIZED/sprint-artifacts/sprint-0/tests.py
```

### 4. Entscheide Pass/Fail
- **Pass:** Alle Tests grün + Inhalte geprüft
  → Fülle Retrospektive aus
  → Weiter zu Sprint 1
- **Fail:** Tests rot ODER Inhalte unvollständig
  → Gib konkretes Feedback
  → Copilot bessert nach

### 5. Retrospektive ausfüllen
In `sprint-0.md` am Ende:
```markdown
## Sprint-Retrospektive

### Was lief gut?
- [x] Aufgaben waren klar
- [x] Tests waren hilfreich

### Prompt-Qualität
- Klarheit: ⭐⭐⭐⭐⭐
- Testbarkeit: ⭐⭐⭐⭐☆

### Verbesserungen für Sprint 1
- Mehr Code-Beispiele gewünscht
```

## Hinweise für GitHub Copilot

### Do's ✅
- **Verwende Repository:** `benjamin-lam/desktop`
- **Atomic Commits:** 1 Aufgabe = 1 Commit
- **Tests zuerst:** Schreibe Test, dann Implementierung
- **Vollständiger Code:** Keine Platzhalter, keine TODOs
- **Type Hints:** Alle Funktionen haben Typen
- **Docstrings:** Google-Style für alle Funktionen

### Don'ts ❌
- **Keine Vermischung:** Nur 1 Sprint zur Zeit
- **Keine manuellen Tests:** Automatisierung ist Pflicht
- **Keine vagen Deliverables:** Messbare Kriterien
- **Keine Sprint-Übersprünge:** Dependencies beachten
- **Keine "Fast-Pass":** Auch bei Pass Retrospektive

### Code-Style
```python
from typing import Optional, Dict, List
from pathlib import Path
import logging

logger = logging.getLogger(__name__)

def process_file(file_path: Path) -> Optional[Dict[str, str]]:
    """
    Verarbeitet eine Datei aus der Inbox.
    
    Args:
        file_path: Pfad zur Datei
        
    Returns:
        Dict mit status und message bei Erfolg, None bei Fehler
        
    Raises:
        FileNotFoundError: Wenn Datei nicht existiert
    """
    try:
        logger.info(f"Verarbeite Datei: {file_path}")
        # Implementierung
        return {"status": "success", "message": "Datei verarbeitet"}
    except Exception as e:
        logger.error(f"Fehler bei {file_path}: {e}")
        return None
```

### Test-Style
```python
import pytest
from pathlib import Path
import tempfile

def test_process_file_success():
    """Test: Gültige Datei wird erfolgreich verarbeitet"""
    # Given: Valide Datei
    with tempfile.NamedTemporaryFile(mode='w', suffix='.txt', delete=False) as f:
        f.write("Test content")
        temp_path = Path(f.name)
    
    # When: Verarbeitung
    result = process_file(temp_path)
    
    # Then: Erfolg
    assert result is not None
    assert result["status"] == "success"
    
    # Cleanup
    temp_path.unlink()
```

## Sprint-Übersicht

### Sprint 0: Scoping & Risiko-Setup (1h) 🟢 Bereit
**Ziel:** Delivery-Plan, Risiko-Register, Test-Plan  
**Dependencies:** Keine  
**Deliverables:**
- `delivery-plan.md`
- `risk-register.md`
- `test-plan.md`

### Sprint 1: Stabilität & Error Handling (1.5h) 🟡 Nach Sprint 0
**Ziel:** Robustes Error Handling, Retry-Logic, Logging  
**Dependencies:** Sprint 0  
**Deliverables:**
- Error Handling in `main.py`
- Retry-Logic in `chroma_client.py`
- Zentrales Logging

### Sprint 2-4: On-Demand 🔵 Nach Sprint 1
Werden erstellt, wenn Sprint 1 abgeschlossen ist.

## Bereit?

**Nächster Schritt:**
```
Lies sprint-0.md und sage dann: "Führe Sprint 0 aus"
```

Viel Erfolg! 🚀
