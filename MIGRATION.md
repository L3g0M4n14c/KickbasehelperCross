# Migration von Swift/iOS zu Flutter/Dart

Dieser Guide hilft Entwicklern, die vom originalen Swift/iOS Kickbasehelper zur Flutter/Dart Cross-Platform Version migrieren möchten.

## Architektur-Vergleich

### Swift (iOS)
```
Kickbasehelper/
├── KickbasehelperApp.swift       # App Entry Point
├── ContentView.swift              # Main View
├── AuthenticationManager.swift   # Auth mit Combine
├── KickbaseManager.swift         # State Management mit Combine
├── Models.swift                  # Alle Modelle in einer Datei
├── MainDashboardView.swift       # Dashboard
└── Services/                     # API Services
```

### Flutter (Cross-Platform)
```
lib/
├── main.dart                      # App Entry Point
├── models/                        # Separate Model-Files
│   ├── user.dart
│   ├── league.dart
│   └── player.dart
├── providers/                     # State Management mit Provider
│   ├── authentication_manager.dart
│   └── kickbase_manager.dart
├── services/                      # API Services
│   └── kickbase_api_service.dart
└── views/                         # UI Views
    ├── login_view.dart
    ├── team_view.dart
    ├── market_view.dart
    ├── sales_recommendation_view.dart
    └── lineup_optimizer_view.dart
```

## Code-Vergleich

### State Management

**Swift (Combine):**
```swift
@MainActor
class KickbaseManager: ObservableObject {
    @Published var leagues: [League] = []
    @Published var selectedLeague: League?
    // ...
}

// Usage in View
@EnvironmentObject var kickbaseManager: KickbaseManager
```

**Flutter (Provider):**
```dart
class KickbaseManager extends ChangeNotifier {
    List<League> _leagues = [];
    League? _selectedLeague;
    
    List<League> get leagues => _leagues;
    League? get selectedLeague => _selectedLeague;
    // ...
    
    void updateData() {
        notifyListeners();
    }
}

// Usage in Widget
Consumer<KickbaseManager>(
  builder: (context, manager, child) {
    return Text(manager.selectedLeague?.name ?? '');
  },
)
```

### Async/Await

**Swift:**
```swift
func loadLeagues() async {
    do {
        let leagues = try await apiService.getLeagues()
        self.leagues = leagues
    } catch {
        print("Error: \(error)")
    }
}
```

**Flutter:**
```dart
Future<void> loadLeagues() async {
    try {
        final leaguesData = await _apiService.getLeagues();
        _leagues = leaguesData.map((json) => League.fromJson(json)).toList();
        notifyListeners();
    } catch (e) {
        debugPrint('Error: $e');
    }
}
```

### UI Components

**Swift (SwiftUI):**
```swift
struct TeamView: View {
    @EnvironmentObject var kickbaseManager: KickbaseManager
    
    var body: some View {
        List(kickbaseManager.teamPlayers) { player in
            HStack {
                Text(player.fullName)
                Spacer()
                Text("\(player.marketValue)")
            }
        }
        .refreshable {
            await kickbaseManager.loadTeamPlayers()
        }
    }
}
```

**Flutter:**
```dart
class TeamView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<KickbaseManager>(
      builder: (context, manager, child) {
        return RefreshIndicator(
          onRefresh: () => manager.loadTeamPlayers(),
          child: ListView.builder(
            itemCount: manager.teamPlayers.length,
            itemBuilder: (context, index) {
              final player = manager.teamPlayers[index];
              return ListTile(
                title: Text(player.fullName),
                trailing: Text('${player.marketValue}'),
              );
            },
          ),
        );
      },
    );
  }
}
```

### Navigation

**Swift (TabView):**
```swift
TabView(selection: $selectedTab) {
    TeamView()
        .tabItem {
            Label("Team", systemImage: "person.3.fill")
        }
        .tag(0)
}
```

**Flutter (BottomNavigationBar):**
```dart
BottomNavigationBar(
  currentIndex: _selectedIndex,
  onTap: (index) => setState(() => _selectedIndex = index),
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.group),
      label: 'Team',
    ),
  ],
)
```

## Wichtige Unterschiede

### 1. JSON Parsing

**Swift:**
- Automatisches Decoding mit `Codable`
- Fallback-Werte müssen explizit behandelt werden

**Flutter:**
- Manuelles Parsing mit `fromJson` Factory
- Einfache Fallback-Werte mit `??` Operator

### 2. UI Framework

**Swift:**
- SwiftUI: Deklaratives UI mit View Protokoll
- iOS-spezifische Komponenten

**Flutter:**
- Widget-basiert: Alles ist ein Widget
- Material Design (plattformübergreifend)

### 3. State Management

**Swift:**
- Combine Framework mit `@Published`
- `@StateObject`, `@ObservedObject`, `@EnvironmentObject`

**Flutter:**
- Provider Package
- `ChangeNotifier` und `Consumer`

### 4. Asynchrone Operationen

**Swift:**
- Async/await mit `async` keyword
- Task API

**Flutter:**
- Future/async/await
- Similar syntax, aber anders in der Implementierung

## Migration Checklist

- [ ] SwiftUI Views zu Flutter Widgets konvertieren
- [ ] Combine Publisher zu ChangeNotifier migrieren
- [ ] JSON Parsing-Logik anpassen
- [ ] API-Calls von URLSession zu http package
- [ ] Navigation von NavigationView zu Navigator
- [ ] Tab-Navigation anpassen
- [ ] State Management umstellen
- [ ] iOS-spezifische Features identifizieren
- [ ] Cross-platform Alternativen finden
- [ ] Tests für beide Plattformen schreiben

## Vorteile der Flutter-Version

1. **Cross-Platform**: Ein Codebase für alle Plattformen
2. **Hot Reload**: Schnellere Entwicklung
3. **Material Design**: Konsistentes UI überall
4. **Web-Support**: App läuft auch im Browser
5. **Größere Community**: Mehr Packages und Ressourcen

## Nachteile/Limitierungen

1. **iOS-native Features**: Einige iOS-spezifische Features sind schwerer umzusetzen
2. **App-Größe**: Flutter-Apps sind tendenziell größer
3. **Performance**: Native Apps können minimal schneller sein
4. **Platform-spezifisches Design**: Material Design unterscheidet sich von iOS Design

## Nächste Schritte

1. Teste die Flutter-App auf verschiedenen Plattformen
2. Implementiere fehlende Features aus der Swift-Version
3. Optimiere für jede Plattform (iOS, Android, Web, Desktop)
4. Füge Platform-spezifische Anpassungen hinzu (z.B. Cupertino-Widgets für iOS)
5. Erstelle Continuous Integration für alle Plattformen

## Ressourcen

- [Flutter für iOS-Entwickler](https://flutter.dev/docs/get-started/flutter-for/ios-devs)
- [Provider Package Dokumentation](https://pub.dev/packages/provider)
- [Flutter State Management](https://flutter.dev/docs/development/data-and-backend/state-mgmt)
- [Dart für Swift-Entwickler](https://dart.dev/guides/language/coming-from/swift-to-dart)
