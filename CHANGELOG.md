# Changelog

Alle wichtigen Änderungen an diesem Projekt werden in dieser Datei dokumentiert.

## [1.0.0] - 2025-10-20

### Hinzugefügt
- Vollständige Flutter/Dart-Implementierung der Kickbase Helper App
- Authentifizierung mit E-Mail und Passwort
- Session-Persistenz mit SharedPreferences
- Team-Ansicht mit sortierbarer Spielerliste
  - Sortierung nach Marktwert, Punkten, Position und Name
  - Budget- und Teamwert-Anzeige
  - Farbcodierte Positionen (TW, ABW, MF, ST)
- Markt-Ansicht mit allen verfügbaren Spielern
  - Anzeige von Preis und Angeboten
  - Marktwert-Vergleich
- Verkaufsempfehlungen-Ansicht
  - Auswahl mehrerer Spieler zum Verkauf
  - Berechnung des Gesamtwerts
  - Visuelle Hervorhebung ausgewählter Spieler
- Aufstellungs-Optimierer
  - Automatische Berechnung der optimalen Aufstellung
  - Formation: 1-4-4-2
  - Sortierung nach Gesamtpunkten
- Liga-Auswahl im App-Header
- Logout-Funktionalität
- Pull-to-Refresh für alle Listen
- Responsive Material Design UI
- Provider-basiertes State Management
- HTTP-basierte API-Integration
- Umfassende Fehlerbehandlung
- Loading-States für alle asynchronen Operationen

### Dokumentation
- README.md mit Installationsanleitung
- BENUTZERHANDBUCH.md mit detaillierter Feature-Beschreibung
- Code-Kommentare für alle wichtigen Funktionen
- Feature-Vergleichstabelle mit Swift-Version

### Tests
- Unit Tests für alle Datenmodelle
- JSON-Parsing-Tests
- Validierung der Modell-Properties

### Technischer Stack
- Flutter SDK >=3.0.0
- Provider 6.0.5 für State Management
- HTTP 1.1.0 für API-Calls
- SharedPreferences 2.2.2 für lokale Datenspeicherung
- Intl 0.18.1 für Währungsformatierung
- Flutter Lints 3.0.0 für Code-Qualität

## [Unveröffentlicht]

### Geplant
- Spieler-Detailansicht mit erweiterten Statistiken
- Transfer-Empfehlungen mit ML/KI
- Push-Benachrichtigungen
- Offline-Modus mit lokalem Caching
- Dark Mode
- Statistik-Charts und Visualisierungen
- Desktop-optimierte Layouts
- Widget-Support für iOS/Android
- Mehrsprachigkeit (DE/EN)
