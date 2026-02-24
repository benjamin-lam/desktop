#!/bin/bash
# Startskript für Auto-Sorter

# Benötigte Host-Ordner anlegen (falls nicht vorhanden)
mkdir -p volumes/inbox
mkdir -p volumes/repo
mkdir -p volumes/chromadb_data
mkdir -p volumes/hf_cache

# Dem Container erlauben, darauf zu schreiben (777)
chmod 755 volumes/inbox
chmod 755 volumes/repo
chmod 755 volumes/chromadb_data
chmod 755 volumes/hf_cache

# Docker Compose starten
docker-compose up -d chromadb
docker-compose run --rm app