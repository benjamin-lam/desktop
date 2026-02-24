import os
import hashlib
from pathlib import Path

def get_file_hash(filepath: Path) -> str:
    """Einfacher Hash, um Duplikate zu erkennen."""
    hasher = hashlib.sha256()
    with open(filepath, 'rb') as f:
        buf = f.read(65536)
        while buf:
            hasher.update(buf)
            buf = f.read(65536)
    return hasher.hexdigest()

def safe_path(base: Path, user_path: str) -> Path:
    """Stellt sicher, dass ein Pfad innerhalb von base liegt."""
    base = base.resolve()
    full = (base / user_path).resolve()
    try:
        full.relative_to(base)
    except ValueError:
        raise ValueError("Pfad außerhalb des erlaubten Bereichs")
    return full
