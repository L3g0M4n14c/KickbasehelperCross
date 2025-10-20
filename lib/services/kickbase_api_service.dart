import 'dart:convert';
import 'package:http/http.dart' as http;

class KickbaseApiService {
  static const String baseUrl = 'https://api.kickbase.com';
  String? _authToken;

  void setAuthToken(String token) {
    _authToken = token;
  }

  Map<String, String> get _headers {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }
    return headers;
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'em': email,
        'pass': password,
        'loy': false,
        'rep': {},
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Login failed: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> getLeagues() async {
    final response = await http.get(
      Uri.parse('$baseUrl/leagues'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['leagues'] ?? [];
    } else {
      throw Exception('Failed to load leagues: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getLeagueUsers(String leagueId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/leagues/$leagueId/users'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load league users: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getUserStats(String leagueId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/leagues/$leagueId/me'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user stats: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> getTeamPlayers(String leagueId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/leagues/$leagueId/me/players'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['players'] ?? [];
    } else {
      throw Exception('Failed to load team players: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> getMarketPlayers(String leagueId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/leagues/$leagueId/market'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['players'] ?? [];
    } else {
      throw Exception('Failed to load market players: ${response.statusCode}');
    }
  }
}
