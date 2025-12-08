import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StopMapView extends StatelessWidget {
  static const String routeName = '/stop-map';

  const StopMapView({super.key});

  static const Color primaryGreen = Color(0xFF008080);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final stop = args['stop'];

    final double lat = stop['latitude'];
    final double lng = stop['longitude'];

    final LatLng stopLocation = LatLng(lat, lng);

    return Scaffold(
      appBar: AppBar(
        title: Text(stop['name']),
        backgroundColor: primaryGreen,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: stopLocation,
          zoom: 16,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('stopMarker'),
            position: stopLocation,
            infoWindow: InfoWindow(title: stop['name']),
          )
        },
      ),
    );
  }
}
