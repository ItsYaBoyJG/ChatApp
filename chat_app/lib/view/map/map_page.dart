import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  Position? _position;
  LatLng _currentLatLng = const LatLng(0, 0);
  final Set<Marker> _markers = <Marker>{};

  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }

  void _getCurrentPos() async {
    _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    LatLng currentPos = LatLng(_position!.latitude, _position!.longitude);

    setState(() {
      _currentLatLng = currentPos;
    });
  }

  getFriendsMarkers(Map friendsList) {
    for (final element in friendsList.entries) {
      Marker marker = Marker(
        markerId: MarkerId(element.value['name']),
        position: _currentLatLng,
      );
      _markers.add(marker);
    }
  }

  void _checkPermissions() async {
    var locationStatus = Permission.locationWhenInUse.status;
    if (await locationStatus.isGranted) {
      _getCurrentPos();
    } else {
      //  _handleLocationPermissions();
      setState(() {});
    }
  }

  @override
  void initState() {
    _checkPermissions();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: false,
            initialCameraPosition: CameraPosition(target: _currentLatLng),
            onMapCreated: _onMapCreated,
            onCameraMove: (position) {},
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            mapToolbarEnabled: false,
            markers: _markers,
          ),
        ],
      ),

      // floatingActionButton: ,
    );
  }
}
