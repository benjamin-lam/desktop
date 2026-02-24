# syntax=docker/dockerfile:1.4
FROM python:3.11-slim-bookworm AS builder

WORKDIR /build

# Systemabhängigkeiten für einige Python-Bibliotheken
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Endgültiges Image
FROM python:3.11-slim-bookworm

# Systemabhängigkeiten für Laufzeit
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Non-root user anlegen und Home-Verzeichnis mit korrekten Berechtigungen vorbereiten
RUN groupadd -r sorter && useradd -r -g sorter -u 1000 sorter \
    && mkdir -p /home/sorter/.cache/huggingface \
    && chown -R sorter:sorter /home/sorter

WORKDIR /app

# Python-Pakete vom builder kopieren
COPY --from=builder /root/.local /home/sorter/.local
ENV PATH=/home/sorter/.local/bin:$PATH
ENV HF_HOME=/home/sorter/.cache/huggingface

# App-Code kopieren
COPY --chown=sorter:sorter . .

USER sorter

CMD ["python", "-u", "main.py"]