# Contributing to Kickbase Helper Cross

Vielen Dank für dein Interesse, zu diesem Projekt beizutragen! 

## Code of Conduct

Sei respektvoll und professionell in allen Interaktionen.

## Wie kann ich beitragen?

### Fehler melden

1. Überprüfe, ob der Fehler bereits gemeldet wurde
2. Erstelle ein neues Issue mit:
   - Klarer Beschreibung des Problems
   - Schritten zur Reproduktion
   - Erwartetes vs. tatsächliches Verhalten
   - Screenshots (falls relevant)
   - Plattform/Version Info

### Features vorschlagen

1. Erstelle ein Issue mit dem Label "enhancement"
2. Beschreibe das gewünschte Feature detailliert
3. Erkläre, warum es nützlich wäre
4. Optional: Schlage eine Implementierung vor

### Code beitragen

#### Setup

1. Fork das Repository
2. Clone deinen Fork:
   ```bash
   git clone https://github.com/DEIN-USERNAME/KickbasehelperCross.git
   cd KickbasehelperCross
   ```

3. Installiere Dependencies:
   ```bash
   flutter pub get
   ```

4. Erstelle einen Feature-Branch:
   ```bash
   git checkout -b feature/dein-feature-name
   ```

#### Entwicklung

1. **Code-Style**: Folge den Dart/Flutter Conventions
   - Nutze `flutter analyze` zum Linting
   - Formatiere mit `dart format lib/`

2. **Tests schreiben**: 
   - Schreibe Unit Tests für neue Features
   - Führe Tests aus: `flutter test`

3. **Commits**:
   - Schreibe aussagekräftige Commit-Messages
   - Nutze konventionelle Commits:
     - `feat: Neue Funktion hinzugefügt`
     - `fix: Fehler behoben`
     - `docs: Dokumentation aktualisiert`
     - `style: Code-Formatierung`
     - `refactor: Code umstrukturiert`
     - `test: Tests hinzugefügt`

#### Pull Request

1. Pushe deinen Branch:
   ```bash
   git push origin feature/dein-feature-name
   ```

2. Erstelle einen Pull Request auf GitHub
3. Beschreibe deine Änderungen detailliert
4. Verlinke relevante Issues
5. Warte auf Review

### Review-Prozess

- Alle PRs werden reviewt
- Änderungen können angefordert werden
- Nach Approval wird der PR gemerged
- Der Maintainer entscheidet über das Mergen

## Entwicklungs-Guidelines

### Projekt-Struktur

```
lib/
├── main.dart              # App Entry Point
├── models/                # Datenmodelle
├── providers/             # State Management
├── services/              # API/Backend Services
├── views/                 # UI Components
└── utils/                 # Hilfsfunktionen (optional)
```

### Code-Konventionen

1. **Naming**:
   - Klassen: PascalCase (`PlayerView`)
   - Variablen/Funktionen: camelCase (`loadPlayers`)
   - Konstanten: lowerCamelCase mit `const` (`primaryColor`)
   - Private: Prefix mit `_` (`_internalMethod`)

2. **Widgets**:
   - StatelessWidget für statische UI
   - StatefulWidget für dynamische UI
   - Consumer für Provider-Integration

3. **State Management**:
   - Provider für globalen State
   - setState für lokalen State
   - ChangeNotifier für komplexe Logik

4. **Error Handling**:
   - Try-catch für API-Calls
   - Benutzerfreundliche Fehlermeldungen
   - Logging mit debugPrint

### Testing

1. **Unit Tests**: `test/models_test.dart`
   - Teste alle Modelle
   - Teste JSON-Parsing
   - Teste Business-Logik

2. **Widget Tests**: `test/widgets_test.dart`
   - Teste UI-Komponenten
   - Teste User-Interaktionen

3. **Integration Tests**: `integration_test/`
   - Teste komplette User-Flows

### Performance

- Nutze `const` Constructors wo möglich
- Vermeide unnötige Rebuilds
- Optimiere Listen mit `ListView.builder`
- Lazy-Loading für große Datensets

### Accessibility

- Füge semantische Labels hinzu
- Teste mit Screen Reader
- Kontrastverhältnis beachten
- Touch-Targets mindestens 48x48dp

## Prioritäten

### Hoch
- Bugfixes
- Sicherheitsupdates
- Performance-Verbesserungen

### Mittel
- Neue Features aus der Swift-Version
- UI/UX-Verbesserungen
- Dokumentation

### Niedrig
- Nice-to-have Features
- Experimentelle Features

## Fragen?

- Erstelle ein Issue mit dem Label "question"
- Kontaktiere die Maintainer auf GitHub

## Lizenz

Durch deinen Beitrag stimmst du zu, dass dein Code unter der gleichen Lizenz wie das Projekt veröffentlicht wird.

---

Danke für deinen Beitrag! 🚀
