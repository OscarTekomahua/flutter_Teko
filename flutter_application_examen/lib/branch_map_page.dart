import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class BranchMapPage extends StatefulWidget {
  @override
  State<BranchMapPage> createState() => _BranchMapPageState();
}

class _BranchMapPageState extends State<BranchMapPage> {
  static const LatLng _branchPosition = LatLng(18.9261, -99.2216);

  static const CameraPosition _initialCamera = CameraPosition(
    target: _branchPosition,
    zoom: 16,
  );

  final Set<Marker> _markers = {};
  LatLng? userPosition;


  @override
  void initState() {
    super.initState();
    _markers.add(
      const Marker(
        markerId: MarkerId('branch'),
        position: _branchPosition,
        infoWindow: InfoWindow(title: 'Sucursal Principal'),
      ),
    );
    getLocation();
  }
  

  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      userPosition = LatLng(pos.latitude, pos.longitude);

     _markers.add(
        Marker(
          markerId: const MarkerId("user_position"),
          position: userPosition!,
          infoWindow: const InfoWindow(title: "Mi ubicación"),
        ),
      );
    });
  }

    @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: const Text('Mapa de sucursal'),
       ),
       body: GoogleMap(
         initialCameraPosition: _initialCamera,
         markers: _markers,
         myLocationButtonEnabled: false,
         zoomControlsEnabled: true,
       ),
     );
   }
}