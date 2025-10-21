# Benutzerhandbuch - Kickbase Helper Cross

## Erste Schritte

### Installation

1. Stelle sicher, dass Flutter installiert ist:
   ```bash
   flutter --version
   ```
   Falls nicht installiert, folge der Anleitung auf https://flutter.dev

2. Clone das Repository:
   ```bash
   git clone https://github.com/L3g0M4n14c/KickbasehelperCross.git
   cd KickbasehelperCross
   ```

3. Installiere die Dependencies:
   ```bash
   flutter pub get
   ```

4. Starte die App:
   ```bash
   flutter run
   ```

### Anmeldung

1. Beim ersten Start der App siehst du den Login-Bildschirm
2. Gib deine Kickbase E-Mail und dein Passwort ein
3. Tippe auf "Anmelden"
4. Nach erfolgreicher Anmeldung wirst du zum Haupt-Dashboard weitergeleitet

## Funktionen

### Team-Ansicht

Die Team-Ansicht zeigt alle Spieler deines aktuellen Teams:

- **Budget-Anzeige**: Oben siehst du dein aktuelles Budget und den Gesamtwert deines Teams
- **Sortierung**: Du kannst die Spieler sortieren nach:
  - Marktwert (Standard)
  - Punkten
  - Position
  - Name
- **Spieler-Details**: Jeder Spieler zeigt:
  - Position (farbcodiert: TW=Gelb, ABW=Grün, MF=Blau, ST=Rot)
  - Name und Verein
  - Aktueller Marktwert
  - Gesamtpunkte
- **Aktualisieren**: Ziehe die Liste nach unten, um die Daten zu aktualisieren

### Markt-Ansicht

Die Markt-Ansicht zeigt alle Spieler, die auf dem Transfermarkt verfügbar sind:

- **Spieler-Liste**: Zeigt alle Spieler auf dem Markt
- **Preis-Info**: 
  - Grün hervorgehobener Preis = Aktuelles Angebot
  - Grauer Text = Marktwert
- **Angebote**: Zeigt die Anzahl der aktuellen Gebote
- **Aktualisieren**: Ziehe die Liste nach unten, um aktuelle Marktdaten zu laden

### Verkaufs-Ansicht

Die Verkaufs-Ansicht hilft dir bei der Auswahl von Spielern zum Verkauf:

- **Spieler auswählen**: Tippe auf die Checkbox neben einem Spieler
- **Gesamtwert**: Oben siehst du den Gesamtwert der ausgewählten Spieler
- **Orange Hervorhebung**: Ausgewählte Spieler sind orange markiert
- **Verwendung**: Nutze diese Ansicht, um zu sehen, welche Spieler du verkaufen könntest und wie viel Budget du dadurch erhältst

### Aufstellungs-Optimierer

Der Aufstellungs-Optimierer erstellt automatisch die beste Aufstellung basierend auf den Punkten:

- **Automatische Berechnung**: Die optimale Aufstellung wird automatisch berechnet
- **Formation**: 1 TW, 4 ABW, 4 MF, 2 ST
- **Gesamtpunkte**: Zeigt die Summe aller Punkte der ausgewählten Spieler
- **Neu berechnen**: Tippe auf "Aufstellung neu berechnen", um die Berechnung zu aktualisieren
- **Details**: Jede Position zeigt:
  - Spielername
  - Verein
  - Punkte
  - Marktwert

## Navigation

### App-Bar (Oben)

- **Liga-Auswahl**: Dropdown-Menü zum Wechseln zwischen deinen Ligen
- **Aktualisieren**: Lädt alle Daten neu
- **Logout**: Meldet dich ab und kehrt zum Login-Bildschirm zurück

### Bottom Navigation (Unten)

- **Team** (👥): Zeigt dein Team
- **Markt** (🛒): Zeigt den Transfermarkt
- **Verkaufen** (💰): Hilft bei Verkaufsentscheidungen
- **Aufstellung** (📋): Optimiert deine Aufstellung

## Tipps & Tricks

### Performance-Optimierung

1. **Daten aktualisieren**: Nutze den Refresh-Button oder Pull-to-Refresh
2. **Liga-Wechsel**: Beim Wechsel der Liga werden automatisch alle Daten neu geladen
3. **Offline-Modus**: Die App funktioniert nur mit Internetverbindung

### Verkaufs-Strategie

1. Nutze die Verkaufs-Ansicht, um verschiedene Szenarien durchzuspielen
2. Achte auf Spieler mit hohem Marktwert aber niedrigen Punkten
3. Behalte die Positionen im Auge - du brauchst genug Spieler für jede Position

### Aufstellungs-Planung

1. Der Optimierer wählt automatisch die punktestärksten Spieler
2. Überprüfe regelmäßig, ob verletzte Spieler ausgetauscht werden müssen
3. Vergleiche die optimale Aufstellung mit deiner aktuellen

## Fehlerbehebung

### Login funktioniert nicht

- Überprüfe deine E-Mail und dein Passwort
- Stelle sicher, dass du eine Internetverbindung hast
- Versuche es später erneut (Server könnte ausgelastet sein)

### Daten werden nicht geladen

- Überprüfe deine Internetverbindung
- Tippe auf den Refresh-Button
- Melde dich ab und wieder an

### App stürzt ab

- Aktualisiere die App auf die neueste Version
- Lösche den Cache (App neu installieren)
- Erstelle einen Bug-Report im GitHub Repository

## Unterschiede zur iOS-Version

Diese Flutter-Version bietet die gleichen Kernfunktionen wie die originale Swift iOS-App, mit einigen Unterschieden:

- **Plattformunabhängig**: Läuft auf allen Plattformen (iOS, Android, Web, Desktop)
- **Material Design**: Nutzt Material Design statt iOS-spezifischem Design
- **Vereinfachte Features**: Fokus auf die wichtigsten Funktionen
- **Zukünftige Updates**: Neue Features werden kontinuierlich hinzugefügt

## Support

Bei Fragen oder Problemen:
- Öffne ein Issue auf GitHub: https://github.com/L3g0M4n14c/KickbasehelperCross/issues
- Kontaktiere den Entwickler über GitHub

## Version

Aktuelle Version: 1.0.0
