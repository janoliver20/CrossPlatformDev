


import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  
  @override
  State<MapScreen> createState() => MapScreenState();
  
}

class MapScreenState extends State<MapScreen> {

  static const CameraPosition _cameraPosition = CameraPosition(target: LatLng(48.36784132608749, 14.514988624961328), zoom: 14);
  late GoogleMapController _controller;
  Location _location = new Location();

  void _onMapCreated(GoogleMapController controller){
    _controller = controller;
    _location.onLocationChanged.listen((location) {

      if (location.longitude != null && location.latitude != null) {
        _controller.animateCamera(
            CameraUpdate.newCameraPosition(
                CameraPosition(target: LatLng(location.latitude!, location.longitude!), zoom: 14)
            )
        );
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _cameraPosition,
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
      ),
    );
  }




  
}

