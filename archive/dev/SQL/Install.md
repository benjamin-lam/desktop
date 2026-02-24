# SQL Server 2022 — Installation (Kurzleitfaden)

Eine praktische Schritt-für-Schritt-Anleitung zur Installation von Microsoft SQL Server 2022 (Express) unter Windows — inklusive der häufigsten Fehlerquellen und schnellen Prüfungen.

---

## 1. Vorbereitungen vor der Installation

### 1.1 Windows als Administrator öffnen
Rechtsklick auf `cmd.exe` → "Als Administrator ausführen".

### 1.2 Windows-Version prüfen
Befehl:
```powershell
winver
```
Wenn du Windows 10 (21H2 oder neuer) oder Windows 11 hast → gut. Bei älteren Versionen (z. B. 1809) kann es Probleme geben.

### 1.3 Alle Updates drauf?
Befehl (falls verfügbar):
```powershell
powershell.exe Install-WindowsUpdate
```
Wenn der Befehl nicht funktioniert: Einstellungen → Update & Sicherheit → Nach Updates suchen → neu starten.  
SQL Server bricht sehr oft ab, wenn Windows nicht aktuell ist.

### 1.4 .NET Framework prüfen
SQL Server 2022 benötigt .NET Framework 4.8.

Prüfen mit:
```cmd
reg query "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" /v Release
```
Wenn eine Zahl ≥ 528040 zurückkommt, ist .NET 4.8+ installiert.  
Wenn der Registrierungsschlüssel nicht gefunden wird → .NET 4.8 von Microsoft installieren.

---

## 2. Installer richtig starten

1. Lade die aktuelle `SQLServer2022-SSEI-Expr.exe` (Express Installer von Microsoft). Wichtig: keine veralteten Offline-EXEs von Drittseiten verwenden.
2. Rechtsklick auf die EXE → "Als Administrator ausführen".
3. Im Setup: Installationstyp: `Basic` oder `Custom`. Für die meisten reicht `Basic`.
4. Lizenz akzeptieren, warten bis Download/Extract durch ist.

Wenn das Setup beim Downloader crasht → notiere: „Abbruch beim Downloader“.

---

## 3. Wichtige Setup-Optionen (Custom-Install, falls sichtbar)

Wenn du die Custom-Oberfläche bekommst:

### 3.1 Features
- unbedingt: Database Engine Services
- optional: z. B. Full-Text Search

### 3.2 Instance Configuration
- Default instance (Name: `MSSQLSERVER`) oder
- Named instance, z. B. `SQLEXPRESS`  
Fehlerquelle: keine Umlaute, Leerzeichen oder Sonderzeichen im Instanznamen verwenden.

### 3.3 Server Configuration
Für lokale Tests ist das Dienstkonto `NT AUTHORITY\SYSTEM` oder "Lokales Systemkonto" in der Regel ausreichend.

### 3.4 Database Engine Configuration
- WICHTIG: Authentication Mode → **Mixed Mode** (SQL Server authentication und Windows authentication) auswählen.
- Lege ein starkes `sa`-Passwort fest (merken!).
- Füge dich selbst unter "Specify SQL Server administrators" hinzu.

Wenn du hier kein Passwort setzen oder keinen Admin hinzufügen kannst → Symptom für Installer-Fehler / Berechtigungsproblem.

---

## 4. Installation beendet – läuft der Dienst wirklich?

Nach "Setup complete" prüfen:

1. Dienste-Konsole öffnen:
```cmd
services.msc
```
2. Suche nach:
- `SQL Server (MSSQLSERVER)` oder
- `SQL Server (SQLEXPRESS)` (bei Named Instance)

Der Status sollte "Wird ausgeführt / Running" sein.  
Wenn der Dienst gestoppt ist oder Starttyp deaktiviert/Start schlägt fehl → weiter zu Punkt 6 (Dienst-Startfehler).

---

## 5. Verbindungstest (ohne GUI)

Teste lokal per Konsole:
```cmd
sqlcmd -S localhost -Q "SELECT @@VERSION"
```
Alternativ bei `SQLEXPRESS`:
```cmd
sqlcmd -S localhost\SQLEXPRESS -Q "SELECT @@VERSION"
```
Erwartetes Ergebnis: eine Zeile mit `Microsoft SQL Server 2022...`

Wenn `sqlcmd` nicht gefunden wird: SQLCMD-Tool nicht installiert — kein Drama. SSMS bringt später alles mit.

Wenn du Fehler bei Anmeldung des Benutzers `sa` bekommst: vermutlich falscher Auth-Modus. Versuche Windows-Auth:
```cmd
sqlcmd -S localhost -E -Q "SELECT @@VERSION"
```
(-E = Windows Integrated Auth)

---

## 6. Häufigster echter Fehler: Dienst startet nicht

Wenn der Dienst nicht startet oder sofort stoppt:

### 6.1 Dienst-Konfiguration prüfen
Doppelklick auf den Dienst → Tab "Anmelden" / "Log On".  
Stelle sicher, dass kein kaputtes Domänen-Konto verwendet wird. Für lokal reicht "Lokales Systemkonto".

### 6.2 Event Viewer prüfen
Öffnen:
```cmd
eventvwr.msc
```
→ Windows-Protokolle → Anwendung → suche nach Einträgen von `MSSQL$SQLEXPRESS` oder `MSSQLSERVER` mit rotem Fehler.

Typische Fehlermeldungen:
- Fehler 17113: Pfad zur `master.mdf` ist falsch / kein Zugriff → Datenverzeichnisse zeigen auf ein nicht existentes Laufwerk.
- Fehler 17058: Dienstkonto hat keine Berechtigung auf die Datendateien → Lösung: Dienstkonto Vollzugriff auf den Datenordner geben. Standardpfad z. B.:
  ```
  C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA
  ```

### 6.3 Speicherplatz prüfen
SQL mag keine zu vollen Platten:
```cmd
wmic logicaldisk get size,freespace,caption
```
Wenn auf `C:` nur ein paar hundert MB frei sind → SQL Server startet oft nicht.

---

## 7. Setup ist durchgelaufen, aber du kannst dich nicht verbinden

Klassiker:

### 7.1 Mixed Mode vergessen
Wenn nur "Windows Authentication" gewählt wurde und du versuchst, dich mit `sa` einzuloggen → funktioniert nicht.  
Lösung: SQL Server Configuration Manager öffnen und Mixed Mode nachträglich aktivieren. Wenn das nicht möglich ist, kann ich die Schritte per Registry/WMI geben.

### 7.2 Browser / Firewall (seltener lokal)
- SQL Server Browser-Dienst muss laufen, wenn du `localhost\SQLEXPRESS` verwendest. Prüfe in `services.msc`: `SQL Server Browser` → Starttyp: Automatisch → starten.
- Firewall: für Remotezugriffe Port 1433 freigeben. Test:
```cmd
netstat -ano | findstr 1433
```
Wenn kein Prozess an 1433 lauscht → TCP/IP evtl. deaktiviert (SQL-Konfiguration prüfen).

---

## 8. Management Studio (GUI)

SSMS ist NICHT mehr Teil der SQL-Server-Installation.

1. Lade `SSMS-Setup-<Version>.exe` von Microsoft.
2. Als Administrator ausführen.
3. Starten → verbinden mit:
   - Servername: `localhost` oder `localhost\SQLEXPRESS`
   - Authentifizierung: Windows-Authentifizierung oder SQL Server-Authentifizierung (mit `sa`)

Wenn SSMS sich nicht verbinden kann, der Dienst aber läuft → wahrscheinlich Authentifizierungs-Thema (gut lösbar).

---

## 9. Wenn die Installation selbst immer abbricht

### 9.1 Mögliche Ursache: alte, halb kaputte Installation
In "Programme & Features" nach folgenden Einträgen suchen und ggf. entfernen:
- Microsoft SQL Server 2xxx
- Microsoft SQL Server Browser
- Microsoft SQL Server Setup Support Files
- SQL Server VSS Writer
- Microsoft ODBC Driver xx for SQL Server

Alles, was zu einer vorherigen SQL-Version gehört und fehlerhaft deinstalliert ist → entfernen.

### 9.2 Nach der Deinstallation (manuell prüfen und löschen, falls vorhanden)
- `C:\Program Files\Microsoft SQL Server\`
- `C:\Program Files (x86)\Microsoft SQL Server\`
- `C:\ProgramData\Microsoft\SQL Server\`  (Hinweis: `C:\ProgramData` ist versteckt)

### 9.3 Neustart
### 9.4 Installer wieder als Administrator starten

Wenn der Installer am Ende ein HTML-Log anbietet: sehr hilfreich. Das Log befindet sich normalerweise unter:
```
C:\Program Files\Microsoft SQL Server\<Version>\Setup Bootstrap\Log\<Datum>\
```
dort: `Summary.txt` und `Detail.txt` — wenn du mir den relevanten Fehlerblock aus `Summary.txt` gibst, kann ich das schnell eingrenzen.

---

## 10. Dein Status-Check jetzt
Sag mir bitte einfach eine Zahl (eine Zahl reicht als Antwort):

1. Ich komme gar nicht durch den Installer (bricht ab).  
2. Installer läuft durch, aber der SQL-Dienst startet nicht.  
3. Dienst läuft, aber ich kann mich nicht verbinden.  
4. Ich bin drin, aber SSMS/GUI zickt.  
5. Etwas völlig anderes.

---
