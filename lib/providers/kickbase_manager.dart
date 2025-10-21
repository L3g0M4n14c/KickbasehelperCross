import 'package:flutter/foundation.dart';
import '../models/league.dart';
import '../models/player.dart';
import '../services/kickbase_api_service.dart';

class KickbaseManager extends ChangeNotifier {
  final KickbaseApiService _apiService = KickbaseApiService();

  List<League> _leagues = [];
  League? _selectedLeague;
  List<Player> _teamPlayers = [];
  List<MarketPlayer> _marketPlayers = [];
  UserStats? _userStats;
  bool _isLoading = false;
  String? _errorMessage;

  List<League> get leagues => _leagues;
  League? get selectedLeague => _selectedLeague;
  List<Player> get teamPlayers => _teamPlayers;
  List<MarketPlayer> get marketPlayers => _marketPlayers;
  UserStats? get userStats => _userStats;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setAuthToken(String token) {
    _apiService.setAuthToken(token);
  }

  Future<void> loadLeagues() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final leaguesData = await _apiService.getLeagues();
      _leagues = leaguesData.map((json) => League.fromJson(json)).toList();

      if (_selectedLeague == null && _leagues.isNotEmpty) {
        _selectedLeague = _leagues.first;
      }
    } catch (e) {
      _errorMessage = 'Fehler beim Laden der Ligen: $e';
      debugPrint('Error loading leagues: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadTeamPlayers() async {
    if (_selectedLeague == null) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final playersData = await _apiService.getTeamPlayers(_selectedLeague!.id);
      _teamPlayers = playersData.map((json) => Player.fromJson(json)).toList();
    } catch (e) {
      _errorMessage = 'Fehler beim Laden der Team-Spieler: $e';
      debugPrint('Error loading team players: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadMarketPlayers() async {
    if (_selectedLeague == null) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final playersData = await _apiService.getMarketPlayers(_selectedLeague!.id);
      _marketPlayers = playersData.map((json) => MarketPlayer.fromJson(json)).toList();
    } catch (e) {
      _errorMessage = 'Fehler beim Laden der Markt-Spieler: $e';
      debugPrint('Error loading market players: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadUserStats() async {
    if (_selectedLeague == null) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final statsData = await _apiService.getUserStats(_selectedLeague!.id);
      _userStats = UserStats.fromJson(statsData);
    } catch (e) {
      _errorMessage = 'Fehler beim Laden der Benutzerstatistiken: $e';
      debugPrint('Error loading user stats: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void selectLeague(League league) {
    _selectedLeague = league;
    notifyListeners();

    loadTeamPlayers();
    loadMarketPlayers();
    loadUserStats();
  }

  Future<void> loadUserData() async {
    await loadLeagues();
    if (_selectedLeague != null) {
      await Future.wait([
        loadTeamPlayers(),
        loadMarketPlayers(),
        loadUserStats(),
      ]);
    }
  }
}
