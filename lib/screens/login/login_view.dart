import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/login_controller.dart';
import '../home/home_view.dart';

class LoginView extends StatelessWidget {
  static const String routeName = '/login';

  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    // Definindo a cor primária verde/teal para o tema Mobi Hora
    const Color primaryGreen = Color(0xFF008080); // Um verde escuro/Teal forte

    final controller = context.watch<LoginController>();
    
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    void showMessage(String message, {bool isSuccess = false}) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isSuccess ? Colors.green : Colors.red,
        ),
      );
    }

    // Usando Theme para garantir que os campos de texto usem a cor verde no foco
    final inputTheme = Theme.of(context).copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: primaryGreen, // Cor de foco e destaque do TextField
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white, // Fundo limpo para contraste
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Ícone e Mensagem de Boas-Vindas (Mobi Hora)
              const Icon(
                Icons.directions_bus_filled, // Ícone de ônibus
                size: 80,
                color: primaryGreen,
              ),
              const SizedBox(height: 24),
              
              // Título (Bem-vindo(a) ao Mobi Hora!)
              const Text(
                'Bem-vindo(a) ao Mobi Hora!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28, 
                  fontWeight: FontWeight.w900, 
                  color: primaryGreen
                ),
              ),
              // Subtítulo
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
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)), // Borda arredondada
                    ),
                    prefixIcon: Icon(Icons.email),
                  ),
                  enabled: !controller.isLoading,
                ),
              ),
              const SizedBox(height: 20),

              // Campo de Senha
              Theme(
                data: inputTheme,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)), // Borda arredondada
                    ),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  enabled: !controller.isLoading,
                ),
              ),
              const SizedBox(height: 30),

              // Mensagem de Erro (Condicional)
              if (controller.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    controller.errorMessage!,
                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),

              // Botão de Login
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.isLoading
                      ? null 
                      : () async {
                            final loginController = context.read<LoginController>();
                            
                            final success = await loginController.performLogin(
                              _emailController.text,
                              _passwordController.text,
                            );

                            if (success) {
                              showMessage('Login realizado com sucesso!', isSuccess: true);
                              Navigator.of(context).pushReplacementNamed(HomeView.routeName);
                            } else if (loginController.errorMessage != null) {
                              showMessage(loginController.errorMessage!);
                            }
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen, // Cor de fundo verde
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Borda arredondada
                    ),
                    elevation: 5, // Sutil sombra para profundidade
                  ),
                  child: controller.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Entrar',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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