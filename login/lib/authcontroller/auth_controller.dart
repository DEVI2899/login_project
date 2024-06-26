
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../authservices/user_auth_service.dart';
import '../models/user.dart';

class AuthController with ChangeNotifier {
  User? _user;
  String? _token;
  final AuthService _authService = AuthService();

  User? get user => _user;
  String? get token => _token;

  Future<void> register(String username, String email, String password) async {
    _user = await _authService.register(username, email, password);
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    final data = await _authService.login(email, password);
    _user = User.fromJson(data['user']);
    _token = data['token'];
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', _token!);
    notifyListeners();
  }

  Future<void> logout() async {
    _user = null;
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    notifyListeners();
  }
}