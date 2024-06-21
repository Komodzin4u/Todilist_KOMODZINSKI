import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class UserProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<void> signIn(String email, String password) async {
    try {
      await _authService.signIn(email, password);
      _isAuthenticated = _authService.accessToken != null;
      notifyListeners();
    } catch (e) {
      print('Sign in failed: $e');
      throw Exception('Sign in failed');
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _isAuthenticated = false;
    notifyListeners();
  }
}
