import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class StopCreateView extends StatefulWidget {
  static const String routeName = '/stop-create';

  const StopCreateView({super.key});

  @override
  State<StopCreateView> createState() => _StopCreateViewState();
}

class _StopCreateViewState extends State<StopCreateView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController latController = TextEditingController();
  final TextEditingController lngController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  static const Color primaryGreen = Color(0xFF008080);

  @override
  void initState() {
    super.initState();
    _carregarLocalizacao(); // AUTO CARREGA GPS AO ABRIR
  }

  // CAPTURA A LOCALIZAÇÃO AUTOMATICAMENTE
  Future<void> _carregarLocalizacao() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception("Permissão de localização negada.");
      }

      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latController.text = pos.latitude.toString();
      lngController.text = pos.longitude.toString();
    } catch (e) {
      setState(() {
        errorMessage = "Erro ao obter localização: $e";
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  // ENVIA A NOVA PARADA PRA API
  Future<void> _criarStop(String token) async {
    final String name = nameController.text.trim();
    final String latitude = latController.text.trim();
    final String longitude = lngController.text.trim();

    if (name.isEmpty || latitude.isEmpty || longitude.isEmpty) {
      setState(() => errorMessage = "Preencha o nome da parada.");
      return;
    }

    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final response = await http.post(
        Uri.parse("https://SUA_API.com/stops/create"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "name": name,
          "latitude": double.parse(latitude),
          "longitude": double.parse(longitude),
        }),
      );

      if (response.statusCode == 201) {
        Navigator.pop(context, true);
      } else {
        setState(() {
          errorMessage = "Erro ao criar stop: ${response.body}";
        });
      }
    } catch (e) {
      setState(() => errorMessage = "Erro: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String token = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cadastrar Stop",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryGreen,
      ),

      body: Padding(
        padding: const EdgeInsets.all(18),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  if (errorMessage != null)
                    Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),

                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Nome da parada",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: latController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: "Latitude (auto)",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: lngController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: "Longitude (auto)",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _criarStop(token),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: primaryGreen,
                      ),
                      child: const Text(
                        "Cadastrar Stop",
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
