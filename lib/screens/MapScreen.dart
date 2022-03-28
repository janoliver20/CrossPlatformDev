


import 'dart:async';


import 'package:Me_Fuel/services/e-control/e-control_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as mapLocation;
import 'package:Me_Fuel/models/GasStation.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  
  @override
  State<MapScreen> createState() => MapScreenState();
  
}

class MapScreenState extends State<MapScreen> {

  static const CameraPosition defaultPosition = CameraPosition(target: LatLng(48.36784132608749, 0.514988624961328), zoom: 14);
  late GoogleMapController _controller;
  mapLocation.Location _location = mapLocation.Location();
  late StreamSubscription _locationSubscription;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  final EControlAPI _api = EControlAPI();

  void _onMapCreated(GoogleMapController controller){
    _controller = controller;


    setLocationChangedListener((location) {

      var longitude = location.longitude;
      var latitude = location.latitude;
      if (longitude != null && latitude != null) {

        _controller.animateCamera(
            CameraUpdate.newCameraPosition(
                CameraPosition(target: LatLng(latitude, longitude), zoom: 14)
            )
        );

        queryGasStationsForMap(latitude, longitude).then((value) => {
          value.forEach((element) {

          })
        });
      }
    });

    //_locationSubscription = _location.onLocationChanged.listen();

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: getInitialCameraPosition(),
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
      ),
    );
  }

  CameraPosition getInitialCameraPosition() {

    _location.getLocation().then((l) {
      var latitude = l.latitude;
      var longitude = l.longitude;

      if (latitude != null && longitude != null) {
        return CameraPosition(target: LatLng(latitude,longitude), zoom: 14);
      }
      return defaultPosition;
    });

    return defaultPosition;
  }

  Future<List<GasStation>> queryGasStationsForMap(double latitude, double longitude) async {



    var localGasStations = await _api.queryGasStationsByAddress(latitude: latitude, longitude: longitude);

    return localGasStations;
  }

  Future<void> setLocationChangedListener(void Function(mapLocation.LocationData event)? onLocationChanged) async {


    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }


    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationSubscription = _location.onLocationChanged.listen(onLocationChanged);

  }




  
}

