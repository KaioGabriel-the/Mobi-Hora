import 'package:flutter/material.dart';

class BusDetailView extends StatelessWidget {
  static const String routeName = '/bus-detail';

  const BusDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String token = args['token'];
    final Map<String, dynamic> bus = args['bus'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Ônibus ${bus['id']}'),
        backgroundColor: const Color(0xFF008080),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bus['linha'] ?? 'Linha desconhecida',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF008080),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              'Horário previsto:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              bus['horario'] ?? '-',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            Text(
              'ID do ônibus:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              bus['id'].toString(),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.delete, color: Colors.white),
                label: const Text('Excluir ônibus'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  print('Excluir ônibus ${bus['id']} com token $token');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}