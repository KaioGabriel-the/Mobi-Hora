import 'package:app_projeto/screens/info/info_view.dart';
import 'package:app_projeto/screens/stops/stops_view.dart';
import 'package:app_projeto/screens/user_profile_view/user_profile_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  static const String routeName = '/home';

  const HomeView({super.key});

  static const Color primaryGreen = Color(0xFF008080);

  /// Botão reutilizável
  Widget _buildActionButton({
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
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryGreen,
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
    // ********** RECEBENDO TOKEN **********
    final String token = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mobi Hora',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryGreen,
        automaticallyImplyLeading: false,
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.directions_bus, size: 100, color: primaryGreen),
              const SizedBox(height: 24),

              const Text(
                'Olá! O que você gostaria de fazer hoje?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 50),

              // ********** PARADAS **********
              _buildActionButton(
                icon: Icons.calendar_month,
                label: 'Paradas',
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    StopsView.routeName,
                    arguments: token,
                  );
                },
              ),

              // ********** PERFIL **********
              _buildActionButton(
                icon: Icons.person,
                label: 'Meu Perfil',
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    UserProfileView.routeName,
                    arguments: token,
                  );
                },
              ),

              // ********** INFORMAÇÕES **********
              _buildActionButton(
                icon: Icons.info_outline,
                label: 'Informações do App',
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    InfoView.routeName,
                    arguments: token,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
