// ---------- BusListView (Com requisição GET) ----------
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../bus_add/bus_add_view.dart';
import '../bus_detail/bus_detail_view.dart';

class BusListView extends StatefulWidget {
  static const String routeName = '/bus-list';

  const BusListView({super.key});

  @override
  State<BusListView> createState() => _BusListViewState();
}

class _BusListViewState extends State<BusListView> {
  Future<List<Map<String, dynamic>>> fetchBuses(String stopId) async {
    final url =
        "https://petaliferous-pearl-vocalic.ngrok-free.dev/routes/?stop_id=$stopId";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);

      // Cada item vem como: { id, code, descript, stop }
      return data.map((bus) => {
          'id': bus['id'],
          'linha': bus['code'],
          'horario': bus['description'], // <--- ALTERADO AQUI
          'stop': bus['stop'],
        }).toList();
    } else {
      throw Exception("Erro ao carregar ônibus");
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String token = args['token'];
    final String stopId = args['stopId'];

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

      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchBuses(stopId),
        builder: (context, snapshot) {
          // ---- Loading ----
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // ---- Erro ----
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar ônibus',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            );
          }

          final buses = snapshot.data ?? [];

          // ---- Lista vazia ----
          if (buses.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum ônibus cadastrado',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          // ---- Lista preenchida ----
          return ListView.builder(
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
                  subtitle: Text('Descrição: ${bus['horario']}'),
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
          );
        },
      ),
    );
  }
}
