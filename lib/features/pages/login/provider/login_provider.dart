import 'package:flutter/material.dart';
import '../model/login_response.dart';
import '../service/login_service.dart';

class LoginProvider extends ChangeNotifier {
  final LoginService _loginService = LoginService();

  bool _isLoading = false;
  String? _error;
  LoginResponse? _loginResponse;

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  LoginResponse? get loginResponse => _loginResponse;
  bool get isLoggedIn => _loginResponse?.token != null;
  User? get userData => _loginResponse?.user;

  Future<bool> login(String username, String password) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _loginService.login(username, password);
      _loginResponse = response;

      if (response.token != null) {
        // Token exists, login successful
        return true;
      } else {
        _error = response.message ?? 'Login gagal';
        return false;
      }
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetError() {
    _error = null;
    notifyListeners();
  }

  void logout() {
    _loginResponse = null;
    _error = null;
    notifyListeners();
  }
}