# syntax=docker/dockerfile:1.4
FROM python:3.11-slim-bookworm AS builder

WORKDIR /build

# Systemabhängigkeiten für Python-Bibliotheken (inkl. Compiler)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    build-essential \
    libmagic1 \
    libmagic-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

# Pip upgrade für bessere Dependency-Resolution
RUN pip install --upgrade pip setuptools wheel

# Installiere Pakete mit verbose output für Debugging
RUN pip install --user --no-cache-dir -r requirements.txt

# Endgültiges Image
FROM python:3.11-slim-bookworm

# Systemabhängigkeiten für Laufzeit
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libmagic1 \
    && rm -rf /var/lib/apt/lists/*

# Feste UID für den User sorter (1000)
RUN groupadd -r sorter && useradd -r -g sorter -u 1000 sorter \
    && mkdir -p /home/sorter/.cache/huggingface \
    && chown -R sorter:sorter /home/sorter

WORKDIR /app

# Python-Pakete vom builder kopieren
COPY --from=builder /root/.local /home/sorter/.local
ENV PATH=/home/sorter/.local/bin:$PATH
ENV HF_HOME=/home/sorter/.cache/huggingface

# App-Code kopieren
COPY --chown=sorter:sorter *.py .

USER sorter

CMD ["python", "-u", "main.py"]