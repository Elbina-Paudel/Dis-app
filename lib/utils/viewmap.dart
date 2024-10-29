import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  MapViewState createState() =>
      MapViewState(); // Changed from _MapViewState to MapViewState
}

class MapViewState extends State<MapView> {
  // Changed from _MapViewState to MapViewState
  late GoogleMapController mapController;
  LatLng _currentPosition =
      const LatLng(27.7172, 85.3240); // Default location (Kathmandu)
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _addDisasterMarkers();
  }

  // Method to fetch user's current location
  Future<void> _getUserLocation() async {
    Location location = Location();
    var currentLocation = await location.getLocation();
    setState(() {
      _currentPosition =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
    });
  }

  // Method to add markers for nearby disaster areas (example locations)
  void _addDisasterMarkers() {
    setState(() {
      _markers.addAll([
        const Marker(
          markerId: MarkerId('disaster1'),
          position: LatLng(27.7172, 85.3240), // Kathmandu, for example
          infoWindow: InfoWindow(title: 'Disaster Zone 1'),
        ),
        const Marker(
          markerId: MarkerId('disaster2'),
          position: LatLng(27.7000, 85.3000), // Another nearby location
          infoWindow: InfoWindow(title: 'Disaster Zone 2'),
        ),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("View Map")),
      body: GoogleMap(
        onMapCreated: (controller) => mapController = controller,
        initialCameraPosition: CameraPosition(
          target: _currentPosition,
          zoom: 14.0,
        ),
        markers: _markers,
        myLocationEnabled: true,
      ),
    );
  }
}
