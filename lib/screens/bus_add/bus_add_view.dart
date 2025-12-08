import 'package:flutter/material.dart';

// ---------- AddBusView (Nova tela de cadastro) ----------
class AddBusView extends StatefulWidget {
  static const String routeName = '/add-bus';

  const AddBusView({super.key});

  @override
  State<AddBusView> createState() => _AddBusViewState();
}

class _AddBusViewState extends State<AddBusView> {
  final TextEditingController linhaController = TextEditingController();
  final TextEditingController horarioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String token = args['token'];
    final String stopId = args['stopId'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Ônibus'),
        backgroundColor: const Color(0xFF008080),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: linhaController,
              decoration: const InputDecoration(
                labelText: 'Linha do ônibus',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: horarioController,
              decoration: const InputDecoration(
                labelText: 'Horário',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  print('Cadastrar ônibus:');
                  print('Token: $token');
                  print('StopId: $stopId');
                  print('Linha: ${linhaController.text}');
                  print('Horário: ${horarioController.text}');
                },
                child: const Text(
                  'Salvar',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}