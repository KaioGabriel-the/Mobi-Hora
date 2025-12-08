// ---------- BusListView (Atualizado) ----------
import 'package:flutter/material.dart';

import '../bus_add/bus_add_view.dart';
import '../bus_detail/bus_detail_view.dart';

class BusListView extends StatelessWidget {
  static const String routeName = '/bus-list';

  const BusListView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String token = args['token'];
    final String stopId = args['stopId'];

    final List<Map<String, dynamic>> buses = [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Ônibus do Stop $stopId'),
        backgroundColor: const Color(0xFF008080),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.pushNamed(
            context,
            AddBusView.routeName,
            arguments: {
              'token': token,
              'stopId': stopId,
            },
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: buses.isEmpty
          ? const Center(
              child: Text(
                'Nenhum ônibus cadastrado',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: buses.length,
              itemBuilder: (context, index) {
                final bus = buses[index];

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 14),
                  child: ListTile(
                    leading: const Icon(Icons.directions_bus, color: Colors.blue),
                    title: Text(bus['linha'], style: const TextStyle(fontSize: 18)),
                    subtitle: Text('Horário: ${bus['horario']}'),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        BusDetailView.routeName,
                        arguments: {
                          'token': token,
                          'bus': bus,
                        },
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

