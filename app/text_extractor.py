import os
from pathlib import Path
import pypdf
import docx
import markdown
from bs4 import BeautifulSoup  # wird für markdown->text benötigt
import logging

logger = logging.getLogger(__name__)

def extract_text(filepath: Path) -> str:
    """Extrahiert Text aus PDF, DOCX, TXT, MD, HTML."""
    suffix = filepath.suffix.lower()
    try:
        if suffix == '.pdf':
            return _extract_pdf(filepath)
        elif suffix == '.docx':
            return _extract_docx(filepath)
        elif suffix in ('.txt', '.md', '.markdown'):
            return _extract_text(filepath)
        elif suffix in ('.html', '.htm'):
            return _extract_html(filepath)
        else:
            logger.warning(f"Nicht unterstützter Dateityp: {suffix}")
            return ""
    except Exception as e:
        logger.error(f"Fehler beim Extrahieren von {filepath}: {e}")
        return ""

def _extract_pdf(filepath: Path) -> str:
    text = ""
    with open(filepath, 'rb') as f:
        reader = pypdf.PdfReader(f)
        for page in reader.pages:
            page_text = page.extract_text()
            if page_text:
                text += page_text + "\n"
    return text.strip()

def _extract_docx(filepath: Path) -> str:
    doc = docx.Document(filepath)
    return "\n".join([para.text for para in doc.paragraphs])

def _extract_text(filepath: Path) -> str:
    with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
        return f.read()

def _extract_html(filepath: Path) -> str:
    with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
        soup = BeautifulSoup(f.read(), 'html.parser')
        return soup.get_text(separator='\n', strip=True)