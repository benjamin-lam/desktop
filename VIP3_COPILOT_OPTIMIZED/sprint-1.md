---
sprint: 1
goal: "Stabilität & Error Handling"
dependencies: ["sprint-0"]
estimated_duration: "1.5h"
critical: true
files_changed:
  - app/main.py
  - app/chroma_client.py
  - app/text_extractor.py
  - app/utils.py
test_files:
  - sprint-artifacts/sprint-1/tests.py
deliverables:
  - Error Handling in main.py
  - Retry-Logic für ChromaDB
  - Validierung in text_extractor.py
  - Zentrales Logging-Setup
---

# Auto Sorter – Sprint 1: Stabilität & Error Handling

## Ziel
Das bestehende System robuster machen und grundlegende Error-Handling-Mechanismen implementieren.

## Inputs
- `delivery-plan.md` (aus Sprint 0)
- Bestehende Dateien: `app/main.py`, `app/chroma_client.py`, `app/text_extractor.py`

---

## Aufgaben

### 1. Error Handling in `main.py` (30 min)

#### Problem
Crashes bei nicht lesbaren Dateien oder ChromaDB-Verbindungsfehlern.

#### Implementierung
1. Try-Catch-Blöcke um kritische Operationen:
   - File Reading (`process_file()")
   - ChromaDB Queries (`find_similar()")
   - Text Extraction (`extract_text()")

2. Graceful Degradation:
   - Bei Fehlern → Datei in `volumes/errors/` verschieben
   - Fehlergrund in `volumes/errors/error.log` schreiben

3. Logging:
   - Level: INFO für normale Operationen, WARNING für recovered errors, ERROR für kritische Fehler
   - Format: `[TIMESTAMP] [LEVEL] [MODULE] – Message`

#### Code-Beispiel
```python
# In app/main.py
import logging
from pathlib import Path

def process_file(filepath: Path) -> dict:
    """
    Verarbeitet eine Datei aus der Inbox.
    
    Args:
        filepath: Pfad zur Datei
        
    Returns:
        dict mit Status und Ergebnis
        
    Raises:
        None (alle Exceptions werden gefangen)
    """
    try:
        # Text extrahieren
        text = extract_text(filepath)
        if not text:
            raise ValueError("Kein Text extrahiert")
        
        # Embedding generieren
        embedding = generate_embedding(text)
        
        # Ähnliche Dokumente finden
        similar = find_similar(embedding)
        
        return {"status": "success", "similar": similar}
        
    except Exception as e:
        logging.error(f"Fehler bei {filepath}: {e}")
        
        # Datei in errors/ verschieben
        error_dir = Path("volumes/errors")
        error_dir.mkdir(exist_ok=True)
        shutil.move(filepath, error_dir / filepath.name)
        
        # Fehler loggen
        with open(error_dir / "error.log", "a") as f:
            f.write(f"{datetime.now()} | {filepath.name} | {str(e)}\n")
        
        return {"status": "error", "message": str(e)}
```

#### Pass-Kriterien
- [ ] Programm stürzt nicht mehr bei defekten Dateien ab
- [ ] Fehlerhafte Dateien werden in `volumes/errors/` verschoben
- [ ] `volumes/errors/error.log` enthält Timestamps und Fehlermeldungen
- [ ] Logs enthalten korrektes Format

#### Commit
```bash
git add app/main.py
git commit -m "feat(sprint-1): add error handling to file processing"
```

---

### 2. Retry-Logic für ChromaDB (20 min)

#### Problem
ChromaDB ist beim Start manchmal nicht verfügbar (Container braucht Zeit).

#### Implementierung
1. Exponential Backoff in `chroma_client.py`:
   - Max. 5 Retry-Versuche
   - Wartezeit: 2^n Sekunden (1s, 2s, 4s, 8s, 16s)
   - Total Max: 31 Sekunden

2. Klare Fehlermeldung nach finalem Retry

#### Code-Beispiel
```python
# In app/chroma_client.py
import time
import logging
from typing import Optional

def connect_to_chromadb(max_retries: int = 5) -> Optional[chromadb.Client]:
    """
    Verbindet zu ChromaDB mit Exponential Backoff.
    
    Args:
        max_retries: Maximale Anzahl Retry-Versuche
        
    Returns:
        ChromaDB Client oder None bei Fehler
    """
    for attempt in range(max_retries):
        try:
            client = chromadb.HttpClient(
                host=os.getenv("CHROMA_HOST", "chromadb"),
                port=int(os.getenv("CHROMA_PORT", 8000))
            )
            
            # Test connection
            client.heartbeat()
            
            logging.info(f"ChromaDB verbunden nach {attempt + 1} Versuch(en)")
            return client
            
        except Exception as e:
            wait_time = 2 ** attempt
            logging.warning(
                f"ChromaDB nicht erreichbar (Versuch {attempt + 1}/{max_retries}). "
                f"Warte {wait_time}s... Fehler: {e}"
            )
            
            if attempt < max_retries - 1:
                time.sleep(wait_time)
            else:
                logging.error(
                    f"ChromaDB nach {max_retries} Versuchen nicht erreichbar. "
                    f"Bitte prüfen: docker-compose ps"
                )
                return None
    
    return None
```

#### Pass-Kriterien
- [ ] Script wartet bis zu 31 Sekunden auf ChromaDB
- [ ] Bei Erfolg: Normaler Start mit Info-Log
- [ ] Bei Misserfolg: Sauberer Exit mit Error-Code 1 und hilfreicher Fehlermeldung
- [ ] Logging zeigt Retry-Versuche an

#### Commit
```bash
git add app/chroma_client.py
git commit -m "feat(sprint-1): add retry logic with exponential backoff for ChromaDB"
```

---

### 3. Validierung in `text_extractor.py` (15 min)

#### Problem
Leere oder zu kleine Dateien verursachen Exceptions.

#### Implementierung
1. Check: Datei > 10 Bytes
2. Check: Extrahierter Text > 20 Zeichen
3. Bei Fail: Return `None` statt Exception

#### Code-Beispiel
```python
# In app/text_extractor.py
from pathlib import Path
import logging

MIN_FILE_SIZE = 10  # Bytes
MIN_TEXT_LENGTH = 20  # Zeichen

def extract_text(filepath: Path) -> Optional[str]:
    """
    Extrahiert Text aus Datei mit Validierung.
    
    Args:
        filepath: Pfad zur Datei
        
    Returns:
        Extrahierter Text oder None bei ungültiger Datei
    """
    # Check 1: Dateigröße
    file_size = filepath.stat().st_size
    if file_size < MIN_FILE_SIZE:
        logging.warning(
            f"Datei {filepath.name} zu klein ({file_size} Bytes). "
            f"Mindestens {MIN_FILE_SIZE} Bytes benötigt."
        )
        return None
    
    # Text extrahieren (je nach Dateityp)
    try:
        if filepath.suffix == '.pdf':
            text = extract_pdf(filepath)
        elif filepath.suffix == '.docx':
            text = extract_docx(filepath)
        elif filepath.suffix in ['.txt', '.md']:
            text = filepath.read_text(encoding='utf-8')
        else:
            logging.warning(f"Unbekannter Dateityp: {filepath.suffix}")
            return None
        
        # Check 2: Text-Länge
        if not text or len(text.strip()) < MIN_TEXT_LENGTH:
            logging.warning(
                f"Datei {filepath.name} enthält zu wenig Text "
                f"({len(text) if text else 0} Zeichen). "
                f"Mindestens {MIN_TEXT_LENGTH} Zeichen benötigt."
            )
            return None
        
        return text.strip()
        
    except Exception as e:
        logging.error(f"Fehler beim Extrahieren von {filepath.name}: {e}")
        return None
```

#### Pass-Kriterien
- [ ] Keine Exceptions bei leeren/kleinen Dateien
- [ ] Logging für übersprungene Dateien mit Grund
- [ ] Return `None` bei ungültigen Dateien
- [ ] Mindestgröße ist konfigurierbar (Konstanten)

#### Commit
```bash
git add app/text_extractor.py
git commit -m "feat(sprint-1): add validation for file size and text length"
```

---

### 4. Zentrales Logging-Setup (25 min)

#### Ziel
Strukturiertes Logging in allen Modulen mit Rotation.

#### Implementierung
1. Logger-Setup in `utils.py`
2. Format: `[TIMESTAMP] [LEVEL] [MODULE] – Message`
3. Log-Rotation: Max. 10 MB pro File, 3 Backups
4. Alle Module nutzen denselben Logger

#### Code-Beispiel
```python
# In app/utils.py
import logging
from logging.handlers import RotatingFileHandler
from pathlib import Path

def setup_logging(log_dir: str = "volumes/logs", log_level: str = "INFO"):
    """
    Konfiguriert zentrales Logging mit Rotation.
    
    Args:
        log_dir: Verzeichnis für Log-Dateien
        log_level: Log-Level (DEBUG, INFO, WARNING, ERROR)
    """
    # Log-Verzeichnis erstellen
    log_path = Path(log_dir)
    log_path.mkdir(parents=True, exist_ok=True)
    
    # Logger konfigurieren
    logger = logging.getLogger()
    logger.setLevel(getattr(logging, log_level.upper()))
    
    # Formatter
    formatter = logging.Formatter(
        '[%(asctime)s] [%(levelname)s] [%(name)s] – %(message)s',
        datefmt='%Y-%m-%d %H:%M:%S'
    )
    
    # File Handler mit Rotation
    file_handler = RotatingFileHandler(
        log_path / "app.log",
        maxBytes=10 * 1024 * 1024,  # 10 MB
        backupCount=3,
        encoding='utf-8'
    )
    file_handler.setFormatter(formatter)
    logger.addHandler(file_handler)
    
    # Console Handler
    console_handler = logging.StreamHandler()
    console_handler.setFormatter(formatter)
    logger.addHandler(console_handler)
    
    logging.info("Logging initialisiert")


# In app/main.py
from utils import setup_logging

if __name__ == "__main__":
    setup_logging(log_level="INFO")
    # ... rest of code
```

#### Pass-Kriterien
- [ ] Alle Module nutzen denselben Logger (kein eigenes `logging.basicConfig()`)
- [ ] Logs werden in `volumes/logs/app.log` geschrieben
- [ ] Alte Logs werden automatisch rotiert (max. 3 Backups)
- [ ] Console und File enthalten beide Logs
- [ ] Format ist konsistent über alle Module

#### Commit
```bash
git add app/utils.py app/main.py app/chroma_client.py app/text_extractor.py
git commit -m "feat(sprint-1): add centralized logging with rotation"
```

---

## Definition of Done (DoD)

### Code-Änderungen
- [ ] `app/main.py` – Error Handling implementiert
- [ ] `app/chroma_client.py` – Retry-Logic hinzugefügt
- [ ] `app/text_extractor.py` – Validierung eingebaut
- [ ] `app/utils.py` – Logger-Setup erstellt

### Neue Verzeichnisse/Dateien
- [ ] `volumes/errors/` existiert (muss in `docker-compose.yml` gemountet werden)
- [ ] `volumes/logs/` existiert
- [ ] `volumes/logs/app.log` wird erstellt beim Start

### Tests
- [ ] Alle Tests grün: `pytest sprint-artifacts/sprint-1/tests.py`
- [ ] Manueller Test: Defekte PDF in Inbox → landet in `errors/`
- [ ] Manueller Test: ChromaDB gestoppt → Script wartet/retried

### Dokumentation
- [ ] `README.md` aktualisiert (Sektion "Fehlerbehandlung" ergänzt)
- [ ] Logging-Format dokumentiert

---

## Test-Case (Automatisiert)

```python name=sprint-artifacts/sprint-1/tests.py
"""
Automatisierte Tests für Sprint 1
"""
import os
import pytest
import tempfile
from pathlib import Path
from unittest.mock import Mock, patch

# Import app modules (anpassen an tatsächliche Struktur)
import sys
sys.path.insert(0, 'app')

from text_extractor import extract_text, MIN_FILE_SIZE, MIN_TEXT_LENGTH
from chroma_client import connect_to_chromadb


class TestTextExtractor:
    """Tests für text_extractor.py"""
    
    def test_file_too_small(self):
        """Test: Datei < 10 Bytes wird abgelehnt"""
        with tempfile.NamedTemporaryFile(mode='w', suffix='.txt', delete=False) as f:
            f.write("Hi")  # 2 Bytes
            temp_path = Path(f.name)
        
        result = extract_text(temp_path)
        assert result is None, "Zu kleine Datei sollte None zurückgeben"
        
        temp_path.unlink()  # Cleanup
    
    def test_text_too_short(self):
        """Test: Text < 20 Zeichen wird abgelehnt"""
        with tempfile.NamedTemporaryFile(mode='w', suffix='.txt', delete=False) as f:
            f.write("Short text")  # 10 Zeichen
            temp_path = Path(f.name)
        
        result = extract_text(temp_path)
        assert result is None, "Zu kurzer Text sollte None zurückgeben"
        
        temp_path.unlink()
    
    def test_valid_text_file(self):
        """Test: Gültige Textdatei wird extrahiert"""
        with tempfile.NamedTemporaryFile(mode='w', suffix='.txt', delete=False) as f:
            f.write("This is a valid text file with more than 20 characters.")
            temp_path = Path(f.name)
        
        result = extract_text(temp_path)
        assert result is not None, "Gültiger Text sollte extrahiert werden"
        assert len(result) > MIN_TEXT_LENGTH
        
        temp_path.unlink()


class TestChromaDBConnection:
    """Tests für chroma_client.py"""
    
    @patch('chromadb.HttpClient')
    def test_connection_success_first_try(self, mock_client):
        """Test: Erfolgreiche Verbindung beim ersten Versuch"""
        mock_instance = Mock()
        mock_instance.heartbeat.return_value = True
        mock_client.return_value = mock_instance
        
        client = connect_to_chromadb(max_retries=5)
        
        assert client is not None
        assert mock_client.call_count == 1
    
    @patch('chromadb.HttpClient')
    @patch('time.sleep')  # Mock sleep für schnelle Tests
    def test_connection_retry_success(self, mock_sleep, mock_client):
        """Test: Erfolgreiche Verbindung nach 2 Retries"""
        mock_instance = Mock()
        # Erste 2 Versuche schlagen fehl, dritter erfolgreich
        mock_instance.heartbeat.side_effect = [
            Exception("Connection refused"),
            Exception("Connection refused"),
            True
        ]
        mock_client.return_value = mock_instance
        
        client = connect_to_chromadb(max_retries=5)
        
        assert client is not None
        assert mock_client.call_count == 3
        assert mock_sleep.call_count == 2  # 2 Wartezeiten
    
    @patch('chromadb.HttpClient')
    @patch('time.sleep')
    def test_connection_max_retries_exceeded(self, mock_sleep, mock_client):
        """Test: Verbindung schlägt nach max retries fehl"""
        mock_instance = Mock()
        mock_instance.heartbeat.side_effect = Exception("Connection refused")
        mock_client.return_value = mock_instance
        
        client = connect_to_chromadb(max_retries=3)
        
        assert client is None
        assert mock_client.call_count == 3
        assert mock_sleep.call_count == 2  # Letzter Versuch wartet nicht


class TestErrorHandling:
    """Tests für Error Handling in main.py"""
    
    def test_error_directory_created(self):
        """Test: volumes/errors/ wird erstellt"""
        error_dir = Path("volumes/errors")
        if error_dir.exists():
            import shutil
            shutil.rmtree(error_dir)
        
        # Simuliere Fehler-Handling (würde in main.py passieren)
        error_dir.mkdir(parents=True, exist_ok=True)
        
        assert error_dir.exists()
    
    def test_error_log_created(self):
        """Test: error.log wird erstellt bei Fehler"""
        error_dir = Path("volumes/errors")
        error_dir.mkdir(parents=True, exist_ok=True)
        error_log = error_dir / "error.log"
        
        # Schreibe Test-Fehler
        from datetime import datetime
        with open(error_log, "a") as f:
            f.write(f"{datetime.now()} | test.pdf | Test error\n")
        
        assert error_log.exists()
        content = error_log.read_text()
        assert "test.pdf" in content
        assert "Test error" in content


class TestLogging:
    """Tests für Logging-Setup"""
    
    def test_log_directory_created(self):
        """Test: volumes/logs/ wird erstellt"""
        from utils import setup_logging
        
        setup_logging(log_dir="volumes/logs")
        
        log_dir = Path("volumes/logs")
        assert log_dir.exists()
        assert (log_dir / "app.log").exists()
    
    def test_log_format(self):
        """Test: Log-Format ist korrekt"""
        import logging
        from utils import setup_logging
        
        setup_logging(log_dir="volumes/logs")
        
        logger = logging.getLogger(__name__)
        logger.info("Test message")
        
        log_file = Path("volumes/logs/app.log")
        content = log_file.read_text()
        
        # Prüfe Format: [TIMESTAMP] [LEVEL] [MODULE] – Message
        assert "[INFO]" in content
        assert "Test message" in content
```

---

## Scope Boundaries

### ✅ In Scope
- Error Handling für File I/O und ChromaDB
- Retry-Logic für ChromaDB-Verbindung
- Validierung von Dateigröße und Text-Länge
- Zentrales Logging mit Rotation

### ❌ Out of Scope
- GUI/Web-Interface für Fehler-Anzeige
- Externe Monitoring-Tools (Sentry, DataDog)
- Error-Recovery (automatisches Neu-Versuchen)
- Feature-Erweiterungen (neue Dateitypen)

### ⚠️ Grenzfälle
**Frage:** Soll Error Handling auch Netzwerk-Fehler bei Embedding-Download abfangen?
- **Entscheidung:** Ja, aber nur mit generischem Try-Catch (keine spezielle Retry-Logic)

---

## Rollback-Plan

### Bei Partial Fail (1-2 Aufgaben fehlgeschlagen)
1. Identifiziere fehlgeschlagene Aufgabe(n)
2. Rollback einzelner Commits:
   ```bash
git log --oneline | grep "sprint-1"
git revert <commit-hash>
   ```
3. Nachbesserung nur für fehlgeschlagene Aufgaben
4. Re-Run: `pytest sprint-artifacts/sprint-1/tests.py`

### Bei Total Fail (>2 Aufgaben fehlgeschlagen)
1. Rollback aller Sprint-1-Commits:
   ```bash
git log --oneline | grep "sprint-1" | awk '{print $1}' | xargs git revert
   ```
2. Zurück zu Sprint 0
3. Re-Planning: Sprint-1-Scope überdenken

---

## Abnahme

### Pass-Kriterien
- [ ] Alle 4 Aufgaben abgeschlossen
- [ ] Alle Tests grün: `pytest sprint-artifacts/sprint-1/tests.py`
- [ ] Manuelle Tests bestanden
- [ ] Dokumentation aktualisiert
- [ ] Code-Review durchgeführt (optional)

### Fail-Strategie
Bei **Fail** bitte angeben:
1. Welche Aufgabe ist fehlgeschlagen?
2. Welcher Test schlägt fehl?
3. Was ist das erwartete vs. tatsächliche Verhalten?
4. Soll ich nachbessern oder rollbacken?

---

## Sprint-Retrospektive (User füllt aus)

### Was lief gut?
- [ ] Aufgaben waren klar und umsetzbar
- [ ] Inline-Tests waren hilfreich
- [ ] Zeitschätzung war realistisch
- [ ] Code-Qualität ist gut

### Was lief schlecht?
- [ ] Aufgaben waren zu komplex
- [ ] Tests waren unklar oder fehlerhaft
- [ ] Zeitschätzung war unrealistisch
- [ ] Zu viele Änderungen auf einmal

### Verbesserungen für Sprint 2
(User-Input hier eintragen)

### Prompt-Qualität (1-5 Sterne)
- **Klarheit:** ☐☐☐☐☐
- **Testbarkeit:** ☐☐☐☐☐
- **Code-Qualität:** ☐☐☐☐☐
- **Zeitschätzung:** ☐☐☐☐☐

### Kommentar
(User-Input hier eintragen)