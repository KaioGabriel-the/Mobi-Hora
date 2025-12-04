import 'package:app_projeto/screens/info/info_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  static const String routeName = '/home';
  
  const HomeView({super.key});

  static const Color primaryGreen = Color(0xFF008080); 

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton.icon(
          icon: Icon(icon, color: Colors.white, size: 28),
          label: Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryGreen.withOpacity(0.9), 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 8,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobi Hora', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: primaryGreen,
        automaticallyImplyLeading: false, 
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Ícone Principal
              const Icon(
                Icons.directions_bus, 
                size: 100, 
                color: primaryGreen,
              ),
              const SizedBox(height: 24),
              
              // Mensagem de Boas-Vindas
              const Text(
                'Olá! O que você gostaria de fazer hoje?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22, 
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333)
                ),
              ),
              const SizedBox(height: 50),

              // 1. Agenda (Ver Ônibus Cadastrados)
              _buildActionButton(
                context: context,
                icon: Icons.calendar_month,
                label: 'Ônibus Cadastrados',
                onPressed: () {
                  print('Navegar para Agenda de Ônibus (Rotas)');
                },
              ),

              // 2. Perfil
              _buildActionButton(
                context: context,
                icon: Icons.person,
                label: 'Meu Perfil',
                onPressed: () {
                  print('Navegar para Meu Perfil');
                },
              ),

              // 3. Informações
              _buildActionButton(
                context: context,
                icon: Icons.info_outline,
                label: 'Informações do App',
                onPressed: () {
                  print('Navegar para Informações do App');
                  Navigator.of(context).pushReplacementNamed(InfoView.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}