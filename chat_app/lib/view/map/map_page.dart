import 'dart:async';
import 'dart:io';

import 'package:chat_app/backend/from_json/get_map_data.dart';
import 'package:flutter/material.dart';
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

  final GetMapData _json = GetMapData();

  LatLng _currentLatLng = const LatLng(0, 0);
  final Set<Marker> _markers = <Marker>{};

  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }

  void _getCurrentPos() async {
    Position? position;
    if (Platform.isAndroid) {
      position = await Geolocator.getCurrentPosition(
          locationSettings: AndroidSettings());
    } else {
      position = await Geolocator.getCurrentPosition(
          locationSettings: AppleSettings());
    }

    LatLng currentPos = LatLng(position.latitude, position.longitude);

    setState(() {
      _currentLatLng = currentPos;
    });
  }

  _getFriendsMarkers() async {
    final friendsList = await _json.readMapJson();
    print(friendsList);
    for (final element in friendsList) {
      final pos = LatLng(
          element['location']['latitude'], element['location']['longitude']);
      Marker marker = Marker(
          markerId: MarkerId(element['id']),
          position: pos,
          icon: AssetMapBitmap(friendsList['avatar_url']));
      _markers.add(marker);
    }
  }

  void _checkPermissions() async {
    var locationStatus = Permission.locationWhenInUse.status;
    if (await locationStatus.isGranted) {
      _getCurrentPos();
    } else {
      //  _handleLocationPermissions();
    }
  }

  @override
  void initState() {
    //  _checkPermissions();
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
