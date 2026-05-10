import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isLoading = false;
  String? _error;
  Customer? _customer;

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Customer? get customer => _customer;

  AuthProvider() {
    _init();
  }

  Future<void> _init() async {
    await ApiService.init();
    _isLoggedIn = ApiService.isAuthenticated;
    if (_isLoggedIn) {
      try {
        _customer = await ApiService.getCustomerMe();
      } catch (e) {
        _isLoggedIn = false;
        await ApiService.clearAuth();
      }
    }
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final result = await ApiService.login(email, password);
      if (ApiService.isAuthenticated) {
        _isLoggedIn = true;
        try {
          _customer = await ApiService.getCustomerMe();
        } catch (_) {}
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = result['message'] ?? 'Login failed';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String fullName, String email, String password, String role) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final result = await ApiService.register(fullName, email, password, role);
      if (result['success'] == true || result['id'] != null) {
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = result['message'] ?? 'Registration failed';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await ApiService.clearAuth();
    _isLoggedIn = false;
    _customer = null;
    notifyListeners();
  }

  Future<void> refreshProfile() async {
    if (!ApiService.isAuthenticated) return;
    try {
      _customer = await ApiService.getCustomerMe();
      notifyListeners();
    } catch (_) {}
  }
}
