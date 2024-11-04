import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  MapViewState createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  late GoogleMapController mapController;
  LatLng currentPosition = const LatLng(27.7172, 85.3240); // Default to Kathmandu
  final Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    initializeLocation();
  }

  Future<void> initializeLocation() async {
    await getUserLocation();
    addDisasterMarkers();
  }

  Future<void> getUserLocation() async {
    Location location = Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    try {
      var currentLocation = await location.getLocation();
      if (mounted) {
        setState(() {
          currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          markers.add(
            Marker(
              markerId: const MarkerId('userLocation'),
              position: currentPosition,
              infoWindow: const InfoWindow(title: 'Your Location'),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            ),
          );
        });

        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: currentPosition,
              zoom: 14.0,
            ),
          ),
        );
      }
    } catch (e) {
      print("Could not get location: $e");
    }
  }

  void addDisasterMarkers() {
    markers.addAll([
      Marker(
        markerId: const MarkerId('disaster1'),
        position: const LatLng(27.7172, 85.3240),
        infoWindow: const InfoWindow(title: 'Disaster Zone 1'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      ),
      Marker(
        markerId: const MarkerId('disaster2'),
        position: const LatLng(27.7000, 85.3000),
        infoWindow: const InfoWindow(title: 'Disaster Zone 2'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("View Map")),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: currentPosition,
                zoom: 14.0,
              ),
            ),
          );
        },
        initialCameraPosition: CameraPosition(
          target: currentPosition,
          zoom: 14.0,
        ),
        markers: markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
