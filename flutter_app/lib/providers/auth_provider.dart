import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel _user = UserModel.empty();
  bool _isLoading = false;
  String? _error;

  UserModel get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user.isAuthenticated;
  String? get error => _error;

  AuthProvider() {
    // Initialize by checking if user is already signed in
    _checkCurrentUser();
    
    // Listen to auth state changes
    _authService.authStateChanges.listen((UserModel? user) {
      if (user != null) {
        _user = user;
      } else {
        _user = UserModel.empty();
      }
      notifyListeners();
    });
  }

  void _checkCurrentUser() {
    final currentUser = _authService.currentUser;
    if (currentUser != null) {
      _user = currentUser;
      notifyListeners();
    }
  }

  Future<bool> signInWithGoogle() async {
    _setLoading(true);
    _error = null;
    
    try {
      final user = await _authService.signInWithGoogle();
      if (user != null) {
        _user = user;
        _setLoading(false);
        return true;
      } else {
        _setError('Google sign-in cancelled or failed');
        return false;
      }
    } catch (e) {
      _setError('Error signing in with Google: $e');
      return false;
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _authService.signOut();
      _user = UserModel.empty();
    } catch (e) {
      _setError('Error signing out: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? errorMessage) {
    _error = errorMessage;
    _isLoading = false;
    notifyListeners();
  }
} 