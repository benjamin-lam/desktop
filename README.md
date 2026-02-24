# 🧨 Auto Sorter – Ordnung mit WUMMS und Köpfchen! 🧠💥

Willkommen in der Zukunft, Schätzchen! Dein `repo`-Ordner sieht aus wie ein Schlachtfeld? Keine Sorge, ich helfe dir! Dieses System ist wie ein treuer Minion: Es starrt ununterbrochen auf deinen **Inbox-Ordner**, schnappt sich alles, was da landet, und sagt dir genau, in welche Schublade der Kram gehört. Semantische Ähnlichkeit, Baby! Das Teil lernt aus deinen Korrekturen – je mehr du sortierst, desto schlauer wird die Kiste!

Alles lokal, alles sicher, keine Cloud-Heinis, die in deinen Sachen rumschnüffeln. Nur du, dein Rechner und eine Menge Magie! ✨

## 🚀 Was kann das Ding?

- **Stalking-Modus:** Überwacht deine `inbox` auf PDFs, DOCX, TXT, MD und HTML.
- **Gehirn-Scan:** Erstellt ein schickes Embedding mit einer KI, die mehr Sprachen spricht als ich Schimpfwörter kenne.
- **Spürnase:** Vergleicht den neuen Kram mit deinem Wissen in der **ChromaDB**.
- **Serviervorschlag:** Macht dir einen Vorschlag, wo die Datei hin soll. Du sagst "Ja", "Nein" oder "Halt die Klappe".
- **Lerneffekt:** Jede Bestätigung macht das System klüger. Irgendwann sortiert es sich fast von selbst!
- **Offline-Power:** Läuft alles bei dir. Internet brauchst du nur einmal kurz zum Modell-Shoppen am Anfang.

## 📦 Was du brauchst (bevor es knallt)

- **Docker & Docker Compose** (Der Standard-Kram von 2026).
- **Mindestens 8 GB RAM** (16 GB sind besser, damit es ordentlich rummst!).
- **2 GB Platz** auf der Platte für das Gehirn (Modell) und die Datenbank.

## 🔧 Installation & Zündung

1. **Repo schnappen**  
   Erstell einen Ordner (z.B. `auto-sorter`) und schmeiß den Code rein.

2. **Geheimzutaten mischen**  
   Kopier `.env.example` zu `.env`. Wenn du viel Deutsch schreibst, nimm:  
   `MODEL_NAME=paraphrase-multilingual-MiniLM-L12-v2`

3. **Nestbau**  
   Erstell die Ordner `volumes/inbox` und `volumes/repo`.  
   Pack deine **schon sortierte Wissensdatenbank** (mit deinen schicken neuen READMEs) in `volumes/repo`. 
4. Die `inbox` bleibt erstmal leer, wie mein Magen vor dem Frühstück! 🧁

4. **ABFAHRT!**  

Beispiel:
   ```bash
   struktur_erstellen.sh
   struktur_mit_readmes.sh
   ```
   Terminal auf im `auto-sorter` Verzeichnis und dann:
   ```bash
    docker-compose up -d chromadb
    echo "Warte auf ChromaDB..."
    sleep 3
    docker-compose run --rm app
   ```
Geduld, Schätzchen! Beim ersten Mal lädt er das Modell (ca. 500 MB). Trink 'nen Tee, während die Bits fließen.
🎮 Nutzung: So wird's gemacht!
Schmeiß eine Datei in volumes/inbox. Boom! In der Konsole geht's rund. Du hast die Macht:

    j – "Ja, Mann! Ab in den Ordner damit!"
    Pfad eintippen – "Nö, schieb's lieber nach 04_Projekttypen/02_E_Commerce!"
    n – "Lass das liegen, das ist Müll." (Bleibt in der Inbox).
    s – "Später vielleicht, ich hab gerade Kekse im Ofen."
    i – "Zeig mir mal kurz, was da überhaupt drinsteht!"

⚙️ Die Hebel (.env)

| Variable | Was es tut | Standard |
| :--- | :--- | :--- |
| **MODEL_NAME** | Das KI-Gehirn | `paraphrase-multilingual-MiniLM-L12-v2` |
| **SIMILARITY_THRESHOLD** | Wie streng? (0..1) – Kleiner ist pingeliger! | `0.6` |
| **SCAN_INTERVAL** | Sekunden, bis Tina wieder in die Inbox linst | `5` |

🧠 Wie lernt das Teil?
Das System liest deine vorhandenen READMEs und speichert sie als Goldstandard. 
Wenn was Neues kommt, guckt die ChromaDB, was am ähnlichsten sieht. Wenn du korrigierst, 
merkt sich das System das neue Beispiel. Keine komplizierte Mathe für dich – einfach nur Ordnung durch Training!
🐛 Wenn's mal klemmt

    "Connection refused": Die Datenbank schläft noch. Gib ihr 'ne Sekunde!
    Modell lädt nicht: Internet-Schluckauf? Einfach den App-Container neustarten.
    Kein Vorschlag: Datei leer oder die KI ist verwirrt. Check mal deine READMEs im Repo!

📄 Lizenz
MIT – Mach damit, was du willst, solange du niemanden in die Luft jagst (außer im Spiel)! 💣
