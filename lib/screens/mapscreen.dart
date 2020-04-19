import 'package:flutter/material.dart';
import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  final geolocator = Geolocator();
  Position userLocation;
  CameraPosition _start;

  void initState() {
    super.initState();
    _getLocation().then((position) {
      setState(() {
        userLocation = position;
      });
    });
    userLocation != null
        ? _start = CameraPosition(
            target: LatLng(userLocation.latitude, userLocation.longitude),
            zoom: 14.4746,
          )
        : _start = CameraPosition(
            target: LatLng(0, 0),
            zoom: 14.4746,
          );
  }

  Future<Position> _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        initialCameraPosition: _start,
        // markers: (userLocation != null)
        //     ? {
        //         Marker(
        //             markerId: null,
        //             position:
        //                 LatLng(userLocation.latitude, userLocation.longitude))
        //       }
        //     : null,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          // _controller.addMarker(positon: LatLng(userLocation.latitude, userLocation.longitude));
        },
      ),
    );
  }
}
