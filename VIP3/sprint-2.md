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