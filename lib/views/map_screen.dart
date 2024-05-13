import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:MapS/views/secrets.dart';  // Asegúrate de que este archivo maneje bien las claves
import 'dart:convert';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  LatLng? currentLocation;
  Marker? currentMarker;
  String? formattedAddress;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _moveToCurrentLocation();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location services are disabled.')),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permissions are denied')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location permissions are permanently denied, we cannot request permissions.')),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
      currentMarker = Marker(
        markerId: MarkerId('currentLocation'),
        position: currentLocation!,
        draggable: true,
        onDragEnd: _onMarkerDragEnd,
      );
    });
  }

  void _onMarkerDragEnd(LatLng newPosition) {
    setState(() {
      currentLocation = newPosition;
      currentMarker = Marker(
        markerId: MarkerId('currentLocation'),
        position: newPosition,
        draggable: true,
        onDragEnd: _onMarkerDragEnd,
      );
      _updateAddress(newPosition);
    });
    mapController!.animateCamera(CameraUpdate.newLatLng(newPosition));
  }

  void _updateAddress(LatLng newPosition) async {
    var response = await http.get(Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=${newPosition.latitude},${newPosition.longitude}&key=${Secrets.API_KEY}'));
    var decoded = jsonDecode(response.body);
    if (decoded['results'].isNotEmpty) {
      setState(() {
        formattedAddress = decoded['results'][0]['formatted_address'];
      });
    }
  }

  void _moveToCurrentLocation() {
    if (currentLocation != null) {
      mapController!.animateCamera(CameraUpdate.newLatLngZoom(currentLocation!, 15.0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: currentLocation!,
                zoom: 15.0,
              ),
              markers: {if (currentMarker != null) currentMarker!},
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
    );
  }
}
