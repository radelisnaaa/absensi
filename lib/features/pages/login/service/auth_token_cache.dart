import 'dart:convert';
// import 'package:shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthTokenCache {
  static const String _keyAuthToken = 'auth_token';
  static const String _keyUserData = 'user_data';
  
  final SharedPreferences _prefs;

  AuthTokenCache(this._prefs);

  // Factory constructor to create an instance with initialized SharedPreferences
  static Future<AuthTokenCache> create() async {
    final prefs = await SharedPreferences.getInstance();
    return AuthTokenCache(prefs);
  }

  // Save auth token and user data
  Future<void> saveAuthData({
    required String token,
    required Map<String, dynamic> userData,
  }) async {
    await _prefs.setString(_keyAuthToken, token);
    await _prefs.setString(_keyUserData, jsonEncode(userData));
  }

  // Get saved auth token
  String? getAuthToken() {
    return _prefs.getString(_keyAuthToken);
  }

  // Get saved user data
  Map<String, dynamic>? getUserData() {
    final userDataString = _prefs.getString(_keyUserData);
    if (userDataString != null) {
      return jsonDecode(userDataString) as Map<String, dynamic>;
    }
    return null;
  }

  // Check if user is logged in
  bool isLoggedIn() {
    final token = getAuthToken();
    return token != null && token.isNotEmpty;
  }

  // Clear all auth data (for logout)
  Future<void> clearAuthData() async {
    await _prefs.remove(_keyAuthToken);
    await _prefs.remove(_keyUserData);
  }
}