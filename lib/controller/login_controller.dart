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

  /// Realiza o login e retorna o token caso tenha sucesso.
  /// Retorna null em caso de erro.
  Future<String?> performLogin(String username, String password) async {
    _setErrorMessage(null);
    _setLoading(true);

    if (username.isEmpty || password.isEmpty) {
      _setErrorMessage('Email e senha não podem ser vazios.');
      _setLoading(false);
      return null;
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

      _setLoading(false);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // garante que "access" existe
        if (data != null && data["access"] != null) {
          return data["access"]; // ⬅ token enviado para a Home
        } else {
          _setErrorMessage("Erro: resposta sem token.");
          return null;
        }
      } else if (response.statusCode == 401) {
        _setErrorMessage('Credenciais inválidas.');
        return null;
      } else {
        _setErrorMessage('Erro inesperado. Código: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _setErrorMessage('Erro ao conectar com o servidor.');
      _setLoading(false);
      return null;
    }
  }
}
