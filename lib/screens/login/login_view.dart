import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/login_controller.dart';
import '../home/home_view.dart';

class LoginView extends StatelessWidget {
  static const String routeName = '/login';

  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF008080);

    final controller = context.watch<LoginController>();

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void showMessage(String message, {bool isSuccess = false}) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isSuccess ? Colors.green : Colors.red,
        ),
      );
    }

    final inputTheme = Theme.of(context).copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: primaryGreen,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.directions_bus_filled,
                size: 80,
                color: primaryGreen,
              ),
              const SizedBox(height: 24),
              const Text(
                'Bem-vindo(a) ao Mobi Hora!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: primaryGreen,
                ),
              ),
              const Text(
                'Acesse sua conta para planejar seu trajeto.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),

              // Campo de Email
              Theme(
                data: inputTheme,
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    prefixIcon: Icon(Icons.person_2),
                  ),
                  enabled: !controller.isLoading,
                ),
              ),
              const SizedBox(height: 20),

              // Campo de Senha
              Theme(
                data: inputTheme,
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  enabled: !controller.isLoading,
                ),
              ),
              const SizedBox(height: 30),

              // Mensagem de erro
              if (controller.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    controller.errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

              // Botão Entrar
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.isLoading
                      ? null
                      : () async {
                          final loginController =
                              context.read<LoginController>();

                          final success =
                              await loginController.performLogin(
                            emailController.text,
                            passwordController.text,
                          );

                          if (success) {
                            showMessage(
                              'Login realizado com sucesso!',
                              isSuccess: true,
                            );
                            Navigator.of(context).pushReplacementNamed(
                              HomeView.routeName,
                            );
                          } else if (loginController.errorMessage != null) {
                            showMessage(loginController.errorMessage!);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  child: controller.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Entrar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),

              // Botão Criar Conta
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: controller.isLoading
                      ? null
                      : () {
                          Navigator.of(context).pushNamed('/register');
                        },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primaryGreen,
                    side: const BorderSide(color: primaryGreen),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Criar conta',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
