import os
import time
import logging
import shutil
from pathlib import Path
import sys
from dotenv import load_dotenv

from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

from text_extractor import extract_text
from embedder import Embedder
from chroma_client import ChromaClient
import utils

# Logging konfigurieren
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[logging.StreamHandler(sys.stdout)]
)
logger = logging.getLogger(__name__)

load_dotenv()

# ===== Konfiguration aus Umgebungsvariablen =====
CHROMA_HOST = os.getenv("CHROMA_HOST", "localhost")
CHROMA_PORT = int(os.getenv("CHROMA_PORT", "8000"))
COLLECTION_NAME = os.getenv("COLLECTION_NAME", "documents")
MODEL_NAME = os.getenv("MODEL_NAME", "paraphrase-multilingual-MiniLM-L12-v2")
INBOX_PATH = Path(os.getenv("INBOX_PATH", "/inbox"))
REPO_PATH = Path(os.getenv("REPO_PATH", "/repo"))
SCAN_INTERVAL = int(os.getenv("SCAN_INTERVAL", "5"))
SIMILARITY_THRESHOLD = float(os.getenv("SIMILARITY_THRESHOLD", "0.6"))
TOP_K = int(os.getenv("TOP_K", "5"))

# ===== Initialisierung der Komponenten =====
embedder = Embedder(MODEL_NAME)

# Retry für ChromaDB
max_retries = 30
retry_interval = 3  # etwas länger
chroma = None
for attempt in range(max_retries):
    try:
        chroma = ChromaClient(CHROMA_HOST, CHROMA_PORT, COLLECTION_NAME)
        # Test-Query: Anzahl der Dokumente abrufen
        count = chroma.collection.count()
        logger.info(f"Verbindung zu ChromaDB hergestellt. {count} Dokumente in Collection.")
        break
    except Exception as e:
        logger.warning(f"ChromaDB nicht erreichbar (Versuch {attempt+1}/{max_retries}): {e}")
        if attempt < max_retries - 1:
            time.sleep(retry_interval)
        else:
            logger.error("ChromaDB nach max. Versuchen nicht erreichbar. Beende.")
            sys.exit(1)

# Initialisierung: READMEs aus dem Repo einlesen und als Trainingsdaten speichern
def init_repo_readmes():

    """Durchsucht REPO_PATH nach README.md Dateien und speichert sie in ChromaDB."""
    logger.info("Initialisiere Datenbank mit READMEs aus dem Repo...")
    count = 0
    for readme_path in REPO_PATH.rglob("README.md"):
        rel_path = readme_path.relative_to(REPO_PATH)
        folder = str(rel_path.parent) if rel_path.parent != Path('.') else "."
        text = extract_text(readme_path)
        if text.strip():
            emb = embedder.embed(text)
            doc_id = f"readme_{folder}_{readme_path.stat().st_mtime}"
            chroma.add_document(
                doc_id=doc_id,
                embedding=emb,
                metadata={"ordner": folder, "quelle": "readme", "pfad": str(readme_path)},
                document=text[:1000]  # nur ein Ausschnitt für Debug
            )
            count += 1
    logger.info(f"{count} READMEs in die Datenbank geladen.")

# Beim Start einmalig READMEs einlesen
init_repo_readmes()

# ===== Watchdog Event Handler =====
class InboxHandler(FileSystemEventHandler):
    def on_created(self, event):
        if not event.is_directory:
            self.process_file(Path(event.src_path))

    def on_moved(self, event):
        if not event.is_directory:
            self.process_file(Path(event.dest_path))

    def process_file(self, filepath: Path):
        # Nur bestimmte Dateitypen verarbeiten
        if filepath.suffix.lower() not in ['.pdf', '.docx', '.txt', '.md', '.markdown', '.html', '.htm']:
            logger.info(f"Ignoriere {filepath}: nicht unterstützter Typ")
            return

        # Warte kurz, falls Datei noch geschrieben wird
        time.sleep(1)

        logger.info(f"Neue Datei erkannt: {filepath}")
        text = extract_text(filepath)
        if not text.strip():
            logger.warning(f"Kein Text extrahierbar aus {filepath}")
            return

        # Embedding erzeugen
        emb = embedder.embed(text)

        # Ähnlichkeitssuche
        similar = chroma.search_similar(emb, n_results=TOP_K)

        if not similar:
            logger.info("Keine ähnlichen Dokumente gefunden.")
            vorschlag = None
        else:
            # Häufigsten Ordnernamen aus den Top-Ergebnissen ermitteln
            ordner_counts = {}
            for doc in similar:
                ordner = doc['metadata'].get('ordner')
                if ordner:
                    ordner_counts[ordner] = ordner_counts.get(ordner, 0) + 1
            if ordner_counts:
                vorschlag = max(ordner_counts, key=ordner_counts.get)
                dist = similar[0]['distance']
                logger.info(f"Vorschlag: {vorschlag} (Distanz: {dist:.3f})")
                if dist > SIMILARITY_THRESHOLD:
                    logger.info("(Distanz hoch – Vorschlag unsicher)")
            else:
                vorschlag = None

        # Nutzerdialog
        print("\n" + "="*60)
        print(f"Datei: {filepath.name}")
        if vorschlag:
            print(f"Vorschlag: Ordner '{vorschlag}'")
        else:
            print("Kein Vorschlag verfügbar.")
        print("Optionen:")
        print("  j / y   - In vorgeschlagenen Ordner verschieben")
        print("  pfad    - Relativen Pfad angeben (z.B. '04_Projekttypen/02_E_Commerce')")
        print("  n / q   - Datei ignorieren (bleibt in Inbox)")
        print("  s       - Überspringen (später bearbeiten)")
        print("  i       - Info (Datei anzeigen)")
        print("="*60)

        while True:
            antwort = input("Ihre Wahl: ").strip().lower()
            if antwort in ('j', 'y'):
                if vorschlag:
                    ziel_ordner = vorschlag
                    break
                else:
                    print("Kein Vorschlag vorhanden. Bitte Pfad eingeben.")
            elif antwort.startswith('/') or antwort[0].isalnum():
                # Benutzer hat einen Pfad eingegeben (relativ zu REPO_PATH)
                ziel_ordner = antwort
                break
            elif antwort in ('n', 'q'):
                logger.info(f"Datei {filepath.name} ignoriert.")
                return
            elif antwort == 's':
                logger.info(f"Datei {filepath.name} übersprungen.")
                return
            elif antwort == 'i':
                print("\n--- Dateiinhalt (Auszug) ---")
                print(text[:1000])
                print("----------------------------\n")
            else:
                print("Ungültige Eingabe.")

        # ===== Datei verschieben/kopieren =====
        # Zielverzeichnis bestimmen
        ziel_ordner_path = utils.safe_path(REPO_PATH, ziel_ordner)
        ziel_ordner_path.mkdir(parents=True, exist_ok=True)
        ziel_datei = ziel_ordner_path / filepath.name
        # Doppelte vermeiden: falls schon vorhanden, Namen ergänzen
        counter = 1
        while ziel_datei.exists():
            stem = filepath.stem
            suffix = filepath.suffix
            ziel_datei = ziel_ordner_path / f"{stem}_{counter}{suffix}"
            counter += 1

        # 1. Datei ins Ziel kopieren
        shutil.copy2(str(filepath), str(ziel_datei))
        logger.info(f"Datei kopiert nach: {ziel_datei}")

        # 2. Original in der Inbox in "processed" verschieben (statt löschen)
        processed_dir = INBOX_PATH / "processed"
        processed_dir.mkdir(exist_ok=True)
        processed_file = processed_dir / filepath.name
        counter = 1
        while processed_file.exists():
            stem = filepath.stem
            suffix = filepath.suffix
            processed_file = processed_dir / f"{stem}_{counter}{suffix}"
            counter += 1

        filepath.rename(processed_file)
        logger.info(f"Original in Inbox verschoben nach: {processed_file}")

        # Lerneffekt: Embedding + korrekten Ordner in DB speichern
        doc_id = f"doc_{utils.get_file_hash(ziel_datei)}"
        chroma.add_document(
            doc_id=doc_id,
            embedding=emb,
            metadata={"ordner": ziel_ordner, "quelle": "user_corrected", "pfad": str(ziel_datei)},
            document=text[:1000]
        )
        logger.info("Lerneintrag in ChromaDB gespeichert.")

# ===== Hauptschleife =====
def main():
    logger.info("Starte Inbox-Überwachung...")
    event_handler = InboxHandler()
    observer = Observer()
    observer.schedule(event_handler, str(INBOX_PATH), recursive=False)
    observer.start()

    try:
        while True:
            time.sleep(SCAN_INTERVAL)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()

if __name__ == "__main__":
    main()