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