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