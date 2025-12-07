import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginController extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<bool> performLogin(String username, String password) async {
    _setErrorMessage(null);
    _setLoading(true);

    if (username.isEmpty || password.isEmpty) {
      _setErrorMessage('Email e senha não podem ser vazios.');
      _setLoading(false);
      return false;
    }

    try {
      final response = await http.post(
        Uri.parse('https://petaliferous-pearl-vocalic.ngrok-free.dev/auth/login/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "username": username,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        _setErrorMessage(null);
        _setLoading(false);
        return true;  
      } else {
        _setErrorMessage('Credenciais inválidas.');
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setErrorMessage('Erro ao conectar com o servidor.');
      _setLoading(false);
      return false;
    }
  }
}
