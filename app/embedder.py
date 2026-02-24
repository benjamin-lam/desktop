from sentence_transformers import SentenceTransformer
import logging
import os

logger = logging.getLogger(__name__)

class Embedder:
    def __init__(self, model_name: str):
        logger.info(f"Lade Embedding-Modell: {model_name} ...")
        self.model = SentenceTransformer(model_name)
        logger.info("Modell geladen.")

    def embed(self, text: str) -> list:
        """Erzeugt ein Embedding für den gesamten Text (trunkiert bei Bedarf)."""
        # SentenceTransformer kann auch längere Texte verarbeiten, aber intern wird geteilt.
        # Für unsere Zwecke reicht das Embedding des gesamten Texts (erster Satz?).
        # Besser: In Chunks aufteilen und mitteln? Für einfache Suche: gesamten Text embedden.
        # Die meisten Modelle haben eine max_seq_length (z.B. 512 Token). Wir lassen truncation=True.
        embedding = self.model.encode(text, convert_to_numpy=True, show_progress_bar=False)
        return embedding.tolist()