import 'package:disaster_app/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  MapViewState createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  // Default to Kathmandu
  LatLng currentPosition = const LatLng(27.7172, 85.3240);
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    initializeMarkers();
  }

  void initializeMarkers() {
    // Add current location marker
    markers.add(
      Marker(
        point: currentPosition,
        child: const Icon(
          Icons.location_on,
          color: Colors.red,
          size: 35,
        ),
      ),
    );

    // Add nearby disaster markers
    addNearbyDisasterMarkers();
  }

  void addNearbyDisasterMarkers() {
    List<LatLng> disasterLocations = [
      const LatLng(27.7172, 85.3240),
      const LatLng(27.7000, 85.3000),
      const LatLng(27.7050, 85.3100),
    ];

    for (var location in disasterLocations) {
      markers.add(
        Marker(
          point: location,
          child: const Icon(
            Icons.warning,
            color: Colors.purple,
            size: 35,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "View Map"),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: currentPosition,
          minZoom: 9.2,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(markers: markers),
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () => launchUrl(
                  Uri.parse('https://openstreetmap.org/copyright'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
