


import 'dart:async';


import 'package:Me_Fuel/services/e-control/e-control_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as mapLocation;
import 'package:Me_Fuel/models/GasStation.dart';
import 'package:location/location.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;
import 'dart:typed_data';


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  
  @override
  State<MapScreen> createState() => MapScreenState();
  
}

class MapScreenState extends State<MapScreen> {

  static const CameraPosition defaultPosition = CameraPosition(target: LatLng(48.36784132608749, 14.514988624961328), zoom: 14);
  late GoogleMapController _controller;
  mapLocation.Location _location = mapLocation.Location();
  late StreamSubscription _locationSubscription;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  final EControlAPI _api = EControlAPI();
  List<GasStation> _listGasStations = List.empty();
  Map<MarkerId, Marker> _markersMap = {};
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller){
    _controller = controller;

    setLocationChangedListener((location) {

      var longitude = location.longitude;
      var latitude = location.latitude;
      if (longitude != null && latitude != null) {

        _locationSubscription.pause();

        _controller.animateCamera(
            CameraUpdate.newCameraPosition(
                CameraPosition(target: LatLng(latitude, longitude), zoom: 14)
            )
        );

        queryGasStationsForMap(latitude, longitude).then((value) {
          addMarkerToList(value);
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
        markers: Set.of(_markersMap.values),
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
      ),
    );
  }

  void addMarkerToList(List<GasStation> gasStations) {

    var customMarkerFuture = getBytesFromAsset(path: "assets/icons/mapMarker.png");

    customMarkerFuture.then((customMarkerImage) {

      gasStations.forEach((gasStation) {
        final markerIdValue = "${gasStation.id}";
        final markerId = MarkerId(markerIdValue);
        createMarker(markerId, gasStation, customMarkerImage);
      });
    });
  }

  void createMarker(MarkerId markerId, GasStation gasStation, Uint8List? customMarkerImage) {

    final marker = Marker(
        markerId: markerId,
        position: LatLng(gasStation.location.latitude, gasStation.location.longitude),
        infoWindow: InfoWindow(
          title: gasStation.name,
          snippet: getMarkerText(gasStation),
          onTap: () {
            print("To Detail Screen");
          },
        ),
        icon: getBitmapDescriptor(customMarkerImage),

    );

    print("Added marker");
    setState(() {
      _markersMap[markerId] = marker;
    });
  }

  BitmapDescriptor getBitmapDescriptor(Uint8List? customMarkerImage) {
    return customMarkerImage != null ? BitmapDescriptor.fromBytes(customMarkerImage) : BitmapDescriptor.defaultMarker;

  }


  String getMarkerText(GasStation gasStation) {

    List<Price> prices = gasStation.prices;
    StringBuffer text = StringBuffer();

    for (Price price in prices) {

      text.writeln(price.label + ": " + price.amount.toString());

    }

    return text.toString();
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


    if (_listGasStations.isEmpty ) {
      _listGasStations = await _api.queryGasStationsByAddress(latitude: latitude, longitude: longitude);
    }
    return _listGasStations;
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


  Future<Uint8List?> getBytesFromAsset({required String path}) async {

    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),targetWidth: 80,
    );
    ui.FrameInfo fi = await codec.getNextFrame();

    return (await fi.image.toByteData(
      format: ui.ImageByteFormat.png,
    ))?.buffer.asUint8List();

  }






  
}

