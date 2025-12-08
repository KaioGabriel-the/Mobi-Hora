import 'dart:convert';
import 'package:app_projeto/screens/stop_create/stop_create_view.dart';
import 'package:app_projeto/screens/stop_detail/stop_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class StopsView extends StatefulWidget {
  static const String routeName = '/stops';

  const StopsView({super.key});

  @override
  State<StopsView> createState() => _StopsViewState();
}

class _StopsViewState extends State<StopsView> {
  bool isLoading = false;
  String? error;
  List<dynamic> stops = [];

  late String token;

  static const Color primaryGreen = Color.fromARGB(255, 0, 128, 128);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    token = ModalRoute.of(context)!.settings.arguments as String;
  }

  Future<void> _buscarStopsProximos() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception('Permissão de localização negada');
      }

      Position posicao = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final double lat = posicao.latitude;
      final double lng = posicao.longitude;
      final limit = 10;

      final uri = Uri.parse(
        'https://petaliferous-pearl-vocalic.ngrok-free.dev/bus-stops/nearby/?lat=$lat&lng=$lng&limit=$limit',
      );
      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode != 200) {
        throw Exception('Erro ao buscar stops');
      }

      final data = jsonDecode(response.body);
      print(data);

      setState(() {
        stops = data['features'] ?? [];
      });
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _abrirDetalheStop(dynamic stop) {
    Navigator.of(context).pushNamed(
      StopDetailView.routeName,
      arguments: {'token': token, 'stop': stop},
    );
  }

  void _abrirCadastroStop() {
    Navigator.of(context).pushNamed(StopCreateView.routeName, arguments: token);
  }

  Widget _buildStopItem(dynamic stop) {
  final props = stop['properties'] ?? {};
  final name = props['name'] ?? 'Stop sem nome';
  final distance = props['distance']?.toStringAsFixed(2) ?? 'N/D';

  return InkWell(
    onTap: () => _abrirDetalheStop(stop),
    borderRadius: BorderRadius.circular(12),
    child: Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.location_on, color: primaryGreen),
        title: Text(name),
        subtitle: Text('Distância: $distance m'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    ),
  );
}


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _buscarStopsProximos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stops Próximos',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryGreen,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryGreen,
        onPressed: _abrirCadastroStop,
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : error != null
            ? Center(
                child: Text(
                  'Erro: $error',
                  style: const TextStyle(color: Colors.red),
                ),
              )
            : stops.isEmpty
            ? const Center(child: Text('Nenhum stop encontrado'))
            : ListView.builder(
                itemCount: stops.length,
                itemBuilder: (context, index) {
                  return _buildStopItem(stops[index]);
                },
              ),
      ),
    );
  }
}
