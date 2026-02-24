# Delivery Plan – Auto Sorter

## Überblick
Dieser Delivery-Plan definiert 8 konkrete Deliverables für die Sprints 1-4 des Auto Sorter Projekts.

## Sprint 1: Stabilität & Error Handling

### 1. Error Handling in main.py
**Beschreibung:** Try-Catch-Blöcke um kritische Operationen (File Reading, ChromaDB Queries)  
**Akzeptanzkriterien:**
- Programm stürzt nicht bei defekten Dateien ab
- Fehlerhafte Dateien werden in `volumes/errors/` verschoben
- Logging mit korrektem Format: `[TIMESTAMP] [LEVEL] [MODULE] – Message`

### 2. Retry-Logic für ChromaDB
**Beschreibung:** Exponential Backoff bei ChromaDB-Verbindungsproblemen  
**Akzeptanzkriterien:**
- Max. 5 Retry-Versuche mit 2^n Sekunden Wartezeit
- Klare Fehlermeldung nach finalem Retry
- Tests: ChromaDB gestoppt → Script wartet/retried

### 3. Validierung in text_extractor.py
**Beschreibung:** Checks für Dateigröße und Text-Länge  
**Akzeptanzkriterien:**
- Dateien < 10 Bytes werden abgelehnt (return None)
- Extrahierter Text < 20 Zeichen wird abgelehnt
- Keine Exceptions bei ungültigen Dateien

### 4. Zentrales Logging-Setup
**Beschreibung:** Strukturiertes Logging mit Rotation  
**Akzeptanzkriterien:**
- Alle Module nutzen denselben Logger
- Logs in `volumes/logs/app.log`
- Log-Rotation: Max. 10 MB, 3 Backups
- Coverage: >70% für main.py, chroma_client.py

---

## Sprint 2: Batch-Processing & Undo

### 5. Batch-Processing
**Beschreibung:** Verarbeite alle Dateien automatisch  
**Akzeptanzkriterien:**
- User kann Batch-Modus wählen (`b`)
- Fortschrittsanzeige: `[3/10] Verarbeite dokument.pdf...`
- Error Summary nach Batch

### 6. Undo-Funktion
**Beschreibung:** Letzte Sortierung rückgängig machen  
**Akzeptanzkriterien:**
- Jede Sortierung wird in `volumes/history.json` protokolliert
- `u`-Befehl verschiebt letzte Datei zurück in Inbox
- Undo nur für letzte Aktion (kein Multi-Undo)

---

## Sprint 3: Performance & Caching

### 7. Embedding-Cache
**Beschreibung:** Cache Embeddings mit Pickle  
**Akzeptanzkriterien:**
- Cache in `volumes/cache/embeddings.pkl`
- Key: File-Hash (SHA256)
- Zweiter Start: 10x schneller als erster Start

### 8. Query-Optimierung
**Beschreibung:** ChromaDB-Queries beschleunigen  
**Akzeptanzkriterien:**
- Query-Zeit < 200ms bei 1000 Dokumenten
- Limit auf Top 5 Ergebnisse
- Benchmark: Vor/Nach-Vergleich dokumentiert

---

## Sprint 4: Testing & Dokumentation

### 9. Unit Tests
**Beschreibung:** Tests für Core-Module  
**Akzeptanzkriterien:**
- 15+ Unit Tests (pytest)
- Coverage: >70% für text_extractor, embedder, chroma_client
- Alle Tests grün

### 10. Integration Tests
**Beschreibung:** End-to-End-Szenarien  
**Akzeptanzkriterien:**
- 4 Integration Tests (Happy Path, Error Path, Batch, Undo)
- Tests laufen in Docker-Umgebung
- Idempotent (mehrfach ausführbar)

---

## Sprint Mapping

### Sprint 1: Stabilität (Critical Path)
- Deliverables: 1-4
- Blockt: Sprint 2, Sprint 4
- Dauer: 1.5h

### Sprint 2: Features
- Deliverables: 5-6
- Depends on: Sprint 1
- Blockt: Sprint 4
- Dauer: 2h

### Sprint 3: Performance (Parallel möglich)
- Deliverables: 7-8
- Depends on: Sprint 1
- Blockt: Keine
- Dauer: 2h

### Sprint 4: Quality Assurance
- Deliverables: 9-10
- Depends on: Sprint 1, 2, 3
- Blockt: Release
- Dauer: 2.5h

---

## Gesamt-Timeline

**Total Estimated Duration:** 8 Stunden  
**Critical Path:** Sprint 1 → Sprint 2 → Sprint 4 (6 Stunden)  
**Parallelisierung möglich:** Sprint 3 parallel zu Sprint 2 (spart 2 Stunden)