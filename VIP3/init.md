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