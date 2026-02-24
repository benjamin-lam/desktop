import chromadb
from chromadb.config import Settings
import logging
from typing import List, Dict, Optional

logger = logging.getLogger(__name__)

import chromadb
from chromadb.config import Settings
import logging
from typing import List, Dict, Optional

logger = logging.getLogger(__name__)

class ChromaClient:
    def __init__(self, host: str, port: int, collection_name: str):
        self.client = chromadb.HttpClient(
            host=host,
            port=port,
            settings=Settings(
                anonymized_telemetry=False,
                chroma_server_http_port=port,
                chroma_server_host=host
            )
        )
        self.collection_name = collection_name
        self.collection = self._get_or_create_collection(collection_name)

    def _get_or_create_collection(self, name: str):
        try:
            # Prüfen, ob Collection existiert
            return self.client.get_collection(name)
        except Exception as e:
            logger.info(f"Collection '{name}' nicht gefunden ({e}), wird erstellt.")
            try:
                return self.client.create_collection(name)
            except Exception as create_e:
                logger.error(f"Fehler beim Erstellen der Collection: {create_e}")
                raise

    def add_document(self, doc_id: str, embedding: list, metadata: dict, document: Optional[str] = None):
        """Fügt ein Dokument (Embedding + Metadaten) hinzu."""
        self.collection.add(
            embeddings=[embedding],
            metadatas=[metadata],
            documents=[document] if document else None,
            ids=[doc_id]
        )

    def search_similar(self, embedding: list, n_results: int = 5) -> List[Dict]:
        """Sucht die n ähnlichsten Dokumente und gibt Metadaten zurück."""
        results = self.collection.query(
            query_embeddings=[embedding],
            n_results=n_results,
            include=["metadatas", "distances"]
        )
        # Ergebnisse aufbereiten
        out = []
        if results['ids'][0]:
            for i in range(len(results['ids'][0])):
                out.append({
                    'id': results['ids'][0][i],
                    'metadata': results['metadatas'][0][i],
                    'distance': results['distances'][0][i] if results['distances'] else None
                })
        return out

    def get_all_documents(self) -> List[Dict]:
        """Holt alle gespeicherten Dokumente (für Debug)."""
        return self.collection.get()