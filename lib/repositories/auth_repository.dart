import 'dart:async';

class AuthRepository {

  Future<bool> signIn(String email, String password) async {

    await Future.delayed(const Duration(seconds: 2));

    if (password == '123456' && email.isNotEmpty) {
      print('AuthRepository: Login bem-sucedido para $email');
      return true;
    } else {
      print('AuthRepository: Falha no login para $email. Senha incorreta.');
      return false;
    }
  }

  Future<void> signOut() async {
    print('AuthRepository: Usuário desconectado.');
    await Future.delayed(const Duration(milliseconds: 500));
  }
}