# Kickbase Helper Cross-Platform

Eine plattformunabhängige Flutter/Dart-Version der Kickbase Helper App.

## Funktionen

- **Team-Ansicht**: Übersicht aller Team-Spieler mit Sortierung nach Wert, Punkten, Position oder Name
- **Markt-Ansicht**: Übersicht aller Spieler auf dem Transfermarkt
- **Verkaufsempfehlungen**: Auswahl von Spielern zum Verkauf mit Gesamtwertberechnung
- **Aufstellungs-Optimierer**: Automatische Berechnung der optimalen Aufstellung basierend auf Punkten

## Projektstruktur

```
lib/
├── main.dart                          # Haupt-App und Dashboard
├── models/                            # Datenmodelle
│   ├── user.dart                      # Benutzer-Modell
│   ├── league.dart                    # Liga-Modelle
│   └── player.dart                    # Spieler-Modelle
├── providers/                         # State Management
│   └── kickbase_manager.dart          # Haupt-State-Manager
├── services/                          # API Services
│   └── kickbase_api_service.dart      # Kickbase API Integration
└── views/                             # UI Views
    ├── team_view.dart                 # Team-Ansicht
    ├── market_view.dart               # Markt-Ansicht
    ├── sales_recommendation_view.dart # Verkaufsempfehlungen
    └── lineup_optimizer_view.dart     # Aufstellungs-Optimierer
```

## Installation

1. Flutter SDK installieren (https://flutter.dev/docs/get-started/install)
2. Dependencies installieren:
   ```bash
   flutter pub get
   ```

## Ausführen

```bash
flutter run
```

Für spezifische Plattformen:
```bash
flutter run -d chrome       # Web
flutter run -d macos        # macOS
flutter run -d windows      # Windows
flutter run -d linux        # Linux
flutter run -d android      # Android
flutter run -d ios          # iOS
```

## Dependencies

- **provider**: State Management
- **http**: HTTP-Anfragen an die Kickbase API
- **shared_preferences**: Lokale Datenspeicherung
- **intl**: Internationalisierung und Währungsformatierung

## Architektur

Die App verwendet das Provider-Pattern für State Management:
- `KickbaseManager` verwaltet den globalen App-State
- `KickbaseApiService` kümmert sich um alle API-Aufrufe
- Views sind als Consumer implementiert und reagieren auf State-Änderungen

## Unterschiede zur Swift-Version

Diese Flutter/Dart-Version ist eine funktionsäquivalente Implementierung der originalen Swift iOS-App ([Kickbasehelper](https://github.com/L3g0M4n14c/Kickbasehelper)) mit folgenden Anpassungen:

1. **Plattformunabhängig**: Läuft auf iOS, Android, Web, Windows, macOS und Linux
2. **Provider statt Combine**: Verwendet Flutter's Provider-Package statt SwiftUI's Combine
3. **Material Design**: Nutzt Material Design statt iOS-spezifische UI-Komponenten
4. **Vereinfachte API**: Fokus auf die Kernfunktionen

### Feature-Vergleich

| Feature | Swift Version | Flutter Version | Status |
|---------|--------------|-----------------|--------|
| Authentifizierung | ✅ | ✅ | Vollständig |
| Team-Übersicht | ✅ | ✅ | Vollständig |
| Markt-Ansicht | ✅ | ✅ | Vollständig |
| Verkaufsempfehlungen | ✅ | ✅ | Vollständig |
| Aufstellungs-Optimierer | ✅ | ✅ | Vollständig |
| Liga-Auswahl | ✅ | ✅ | Vollständig |
| Spieler-Details | ✅ | ⏳ | Geplant |
| Transfer-Empfehlungen | ✅ | ⏳ | Geplant |
| Push-Benachrichtigungen | ✅ | ⏳ | Geplant |
| Offline-Caching | ✅ | ⏳ | Geplant |

## Zukünftige Erweiterungen

- [ ] Spieler-Detailansicht mit Statistiken und Charts
- [ ] Transfer-Empfehlungen mit KI/ML
- [ ] Push-Benachrichtigungen für wichtige Events
- [ ] Offline-Modus mit Caching
- [ ] Statistik-Charts und Visualisierungen
- [ ] Dark Mode
- [ ] Mehrsprachigkeit (DE/EN)
- [ ] Widget-Support für iOS/Android
- [ ] Desktop-optimierte Layouts

## Beitragen

Beiträge sind willkommen! Bitte erstelle einen Pull Request oder öffne ein Issue für Vorschläge.

## Verwandte Projekte

- [Kickbasehelper (Swift/iOS)](https://github.com/L3g0M4n14c/Kickbasehelper) - Die originale iOS-Version

## Lizenz

Siehe LICENSE-Datei im Root-Verzeichnis.
