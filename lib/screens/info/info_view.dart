import 'package:flutter/material.dart';

class InfoView extends StatelessWidget {
  static const String routeName = '/info';
  
  const InfoView({super.key});

  // Cor primária do Mobi Hora
  static const Color primaryGreen = Color(0xFF008080); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sobre o Mobi Hora', 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        ),
        backgroundColor: primaryGreen,
        iconTheme: const IconThemeData(color: Colors.white), // Ícone de voltar branco
      ),
      body: const Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Ícone Principal do App
              Icon(
                Icons.directions_bus_filled, 
                size: 100, 
                color: primaryGreen,
              ),
              SizedBox(height: 20),

              // Título
              Text(
                'Mobi Hora',
                style: TextStyle(
                  fontSize: 32, 
                  fontWeight: FontWeight.w900, 
                  color: primaryGreen
                ),
              ),
              SizedBox(height: 40),

              // Seção de Criação
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                color: Color(0xFFE0F2F1), // Fundo verde bem claro para o card
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Mensagem Principal
                      Text(
                        'Desenvolvimento:',
                        style: TextStyle(
                          fontSize: 20, 
                          fontWeight: FontWeight.bold, 
                          color: primaryGreen
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Este aplicativo foi idealizado e criado por:',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '• Kauã',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF388E3C)),
                      ),
                      Text(
                        '• Kaio',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF388E3C)),
                      ),
                      SizedBox(height: 20),
                      
                      // Mensagem sobre a Matéria
                      Text(
                        'Trabalho desenvolvido para a disciplina de Dispositivos Móveis.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Um projeto feito para o professor mais gato do IFPI!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16, 
                          fontWeight: FontWeight.bold, 
                          color: Color(0xFF1B5E20)
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 40),
              
              Text(
                'Versão 1.0.0',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}