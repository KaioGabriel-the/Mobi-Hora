import 'package:app_projeto/screens/stop_map_view/stop_map_view.dart';
import 'package:flutter/material.dart';

class StopDetailView extends StatelessWidget {
  static const String routeName = '/stop-detail';

  const StopDetailView({super.key});

  static const Color primaryGreen = Color(0xFF008080);

  @override
  Widget build(BuildContext context) {
    // Recebendo token + stop
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String token = args['token'];
    final dynamic stop = args['stop'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Stop'),
        backgroundColor: primaryGreen,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stop['name'] ?? 'Sem nome',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Latitude: ${stop['latitude'] ?? '-'}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Longitude: ${stop['longitude'] ?? '-'}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 12),

            Text(
              'Distância: ${stop['distance'] ?? '-'} metros',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 40),

            // ---------------- Botão para abrir mapa ----------------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.map, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    StopMapView.routeName,
                    arguments: {
                      'token': token,
                      'stop': stop,
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                label: const Text(
                  'Ver no mapa',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ---------------- Botão de editar ----------------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/stop-edit',
                    arguments: {
                      'token': token,
                      'stop': stop,
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Editar Stop',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
