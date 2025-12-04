import 'package:flutter/material.dart';

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

  Future<bool> performLogin(String email, String password) async {
    _setErrorMessage(null); // Limpa o erro anterior
    _setLoading(true);

    if (email.isEmpty || password.isEmpty) {
      _setErrorMessage('Email e senha não podem ser vazios.');
      _setLoading(false);
      return false;
    }
    
    await Future.delayed(const Duration(seconds: 2));

    if (email == 'teste@exemplo.com' && password == '123456') {
      _setErrorMessage(null); // Limpa o erro em caso de sucesso
      _setLoading(false);
      return true; // Login bem-sucedido
    } else {
      _setErrorMessage('Credenciais inválidas. Tente novamente.');
      _setLoading(false);
      return false; // Login falhou
    }
  }
}