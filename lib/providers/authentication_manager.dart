import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/kickbase_api_service.dart';
import '../models/user.dart';

class AuthenticationManager extends ChangeNotifier {
  final KickbaseApiService _apiService = KickbaseApiService();
  
  User? _currentUser;
  String? _accessToken;
  bool _isAuthenticated = false;
  String? _errorMessage;

  User? get currentUser => _currentUser;
  String? get accessToken => _accessToken;
  bool get isAuthenticated => _isAuthenticated;
  String? get errorMessage => _errorMessage;

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('access_token');
    
    if (_accessToken != null) {
      _isAuthenticated = true;
      _apiService.setAuthToken(_accessToken!);
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.login(email, password);
      
      _accessToken = response['tkn'];
      if (_accessToken != null) {
        _apiService.setAuthToken(_accessToken!);
        _isAuthenticated = true;

        // Save token to local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', _accessToken!);

        // Parse user data if available
        if (response['user'] != null) {
          _currentUser = User.fromJson(response['user']);
        }

        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = 'Login fehlgeschlagen: $e';
      debugPrint('Login error: $e');
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _accessToken = null;
    _currentUser = null;
    _isAuthenticated = false;

    // Clear stored token
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');

    notifyListeners();
  }
}
