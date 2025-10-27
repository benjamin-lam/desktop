1. Vorbereitungen vor der Installation

1.1. Windows als Admin öffnen

Rechtsklick auf cmd.exe → Als Administrator ausführen.


1.2. Windows-Version prüfen

winver

Wenn du Windows 10 (21H2 oder neuer) oder Windows 11 hast → gut.

Wenn du was Älteres siehst (z. B. 1809 etc.), kann das Ärger machen.


1.3. Alle Updates drauf?

powershell.exe Install-WindowsUpdate

Falls der Befehl nicht geht, einfach normal Windows Update durchlaufen lassen: Einstellungen → Update & Sicherheit → Nach Updates suchen → neu starten.

SQL Server bricht sehr oft ab, wenn Windows nicht aktuell ist.

1.4. .NET Framework prüfen

SQL Server 2022 braucht .NET Framework 4.8.

Prüfen:

reg query "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" /v Release

Wenn eine Zahl ≥ 528040 zurückkommt, ist .NET 4.8+ drauf.

Wenn du Der angegebene Registrierungsschlüssel ... wurde nicht gefunden bekommst → .NET 4.8 installieren (Microsoft Installer, sehr klein).



---

2. Installer richtig starten

2.1. Hole dir die aktuelle SQLServer2022-SSEI-Expr.exe (Express Installer von Microsoft).
Wichtig: Nicht alte Offline-EXEs von Drittseiten benutzen.

2.2. Rechtsklick auf die EXE → Als Administrator ausführen.

2.3. Im Setup:

Installationstyp: Basic oder Custom

Für die meisten reicht Basic.


Lizenz akzeptieren.

Warten bis Download/Extract durch ist.


Wenn das Setup hier schon crasht → notieren: “Abbruch beim Downloader”.


---

3. Wichtige Setup-Optionen (Custom-Install, falls du die siehst)

Falls du die Custom/Oberfläche bekommst:

3.1. Features

Database Engine Services anhaken (Pflicht)

Andere Dinge wie Full-Text Search sind optional


3.2. Instance Configuration

Entweder Default instance mit Name MSSQLSERVER

Oder Named instance, z. B. SQLEXPRESS


Fehlerquelle: Umlaute, Leerzeichen, Sonderzeichen im Instanznamen → nicht machen.

3.3. Server Configuration

Für den SQL Server-Dienst-Account kannst du einfach NT AUTHORITY\SYSTEM oder Lokales Systemkonto lassen, das ist okay fürs lokale Testen.


3.4. Database Engine Configuration

WICHTIG: Authentication Mode

Wähle Mixed Mode (SQL Server authentication and Windows authentication)

Lege ein starkes sa-Passwort fest (merken!)


Füge dich selbst als Admin hinzu unter Specify SQL Server administrators.


Wenn du hier kein Passwort setzen kannst oder kein Admin hinzufügen kannst → das ist ein klares Symptom für Installer-Fehler/Rechteproblem.


---

4. Installation beendet – aber läuft der Dienst wirklich?

Nach “Setup complete” bitte prüfen:

4.1. Dienste-Konsole öffnen:

services.msc

4.2. Such nach:

SQL Server (MSSQLSERVER) oder

SQL Server (SQLEXPRESS) (wenn du eine Named Instance gewählt hast)


Der Status sollte Wird ausgeführt / Running sein.

Wenn Gestartet/Running → alles gut.

Wenn Beendet oder Starttyp: Deaktiviert oder Start schlägt fehl → wir sind bei einem Dienst-Startfehler (siehe Punkt 6).



---

5. Verbindungstest (ohne GUI)

5.1. Teste lokal per Konsole:

sqlcmd -S localhost -Q "SELECT @@VERSION"

Alternativ, wenn du SQLEXPRESS als Instanz verwendet hast:

sqlcmd -S localhost\SQLEXPRESS -Q "SELECT @@VERSION"

Erwartetes Ergebnis: Du bekommst eine Zeile mit Microsoft SQL Server 2022...

Wenn du Der Befehl "sqlcmd" ist entweder falsch geschrieben... bekommst:

Dann ist das SQLCMD-Tool nicht installiert. Kein Drama.

Später kannst du SQL Server Management Studio (SSMS) installieren, das bringt alles mit.


Wenn du Fehler bei der Anmeldung des Benutzers 'sa' bekommst:

Dann hast du dich vermutlich nicht mit dem richtigen Modus verbunden. Versuch Windows-Auth mit:


sqlcmd -S localhost -E -Q "SELECT @@VERSION"

(-E = Windows Integrated Auth)


---

6. Häufigster echter Fehler: Dienst startet nicht

Wenn der Dienst nicht startet oder sofort stoppt:

6.1. Doppelklick auf den Dienst → Tab Protokoll / Log On

Stell sicher, dass er NICHT mit irgendeinem kaputten Domänen-Account läuft.

Für lokal reicht Lokales Systemkonto.


6.2. Event Viewer prüfen:

eventvwr.msc

→ Windows-Protokolle → Anwendung
→ Such nach Einträgen von MSSQL$SQLEXPRESS oder MSSQLSERVER mit rotem Fehler.

Typische Meldungen:

Fehler 17113: Pfad zur master.mdf ist falsch / kein Zugriff
→ passiert, wenn die Datenverzeichnisse auf ein Laufwerk zeigen, das nicht existiert.

Fehler 17058: Dienstkonto hat keine Berechtigung auf die Datendateien
→ Lösung: Dem Dienstkonto Vollzugriff auf den Datenordner geben: Standardmäßig z. B.
C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA


6.3. Speicherplatz SQL mag keine zu vollen Platten. Check:

wmic logicaldisk get size,freespace,caption

Wenn auf C: nur ein paar hundert MB frei sind → SQL Server startet oft nicht.


---

7. Setup ist durchgelaufen, aber du kannst dich nicht verbinden

Das ist ein Klassiker.

7.1. Mixed Mode vergessen
Wenn du nur “Windows Authentication” gewählt hast und jetzt mit sa rein willst → geht nicht.
Lösung: SQL Server Configuration Manager öffnen und Mixed Mode nachträglich aktivieren. (Wenn du da nicht reinkommst, sag mir Bescheid, dann kriegst du die Schritte per Registry/WMI.)

7.2. Browser/FW-Thema (seltener lokal)

SQL Server Browser Dienst muss laufen, wenn du localhost\SQLEXPRESS verwendest. Prüfe in services.msc:
SQL Server Browser → Starttyp Automatisch → Starten.


7.3. Firewall Normalerweise lokal kein Thema, aber falls du wirklich remotest:
Port 1433 freigeben. Test:

netstat -ano | findstr 1433

Wenn kein Prozess lauscht → TCP/IP ist evtl. deaktiviert.


---

8. Management Studio (GUI)

Wichtig: SSMS ist NICHT mehr Teil der SQL-Server-Installation.

8.1. Hole dir SSMS-Setup-<Version>.exe von Microsoft.
8.2. Als Admin ausführen.
8.3. Starten → Verbinden mit:

Servername: localhost

Oder: localhost\SQLEXPRESS

Authentifizierung: Windows-Authentifizierung oder SQL Server-Authentifizierung (mit sa)


Wenn SSMS sich nicht verbinden kann, aber der Dienst läuft, hast du sehr wahrscheinlich nur ein Auth-Thema, kein Engine-Thema. Das ist gut lösbar.


---

9. Wenn die Installation selbst immer abbricht

Wenn du gar nicht so weit kommst, sondern das Setup vorher abbricht:

9.1. Typische Ursache: alte, halb kaputte Installation

Such in “Programme & Features” nach:

Microsoft SQL Server 2xxx

Microsoft SQL Server Browser

Microsoft SQL Server Setup Support Files

SQL Server VSS Writer

Microsoft ODBC Driver xx for SQL Server


Alles, was offensichtlich zu einer vorherigen SQL-Version gehört und rot markiert / fehlerhaft deinstalliert ist → runterwerfen.

9.2. Danach lösch (wenn vorhanden):

C:\Program Files\Microsoft SQL Server\
C:\Program Files (x86)\Microsoft SQL Server\
C:\ProgramData\Microsoft\SQL Server\

💡 C:\ProgramData\... ist versteckt.

9.3. Neustart.
9.4. Installer wieder als Admin starten.

Wenn der Installer dir am Ende ein HTML-Log anbietet: Das ist Gold. Das Ding liegt normalerweise unter:

C:\Program Files\Microsoft SQL Server\<Version>\Setup Bootstrap\Log\<Datum>\
Summary.txt
Detail.txt

Wenn du mir den relevanten Fehlerblock aus Summary.txt gibst, kriegen wir das sofort eingegrenzt.


---

10. Dein Status-Check jetzt

Sag mir bitte einfach (eine Zahl reicht als Antwort):

1. Ich komme gar nicht durch den Installer (bricht ab).


2. Installer läuft durch, aber der SQL-Dienst startet nicht.


3. Dienst läuft, aber ich kann mich nicht verbinden.


4. Ich bin drin, aber SSMS/GUI zickt.


5. Etwas völlig anderes.
