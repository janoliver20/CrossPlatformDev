


import 'dart:async';


import 'package:Me_Fuel/services/e-control/e-control_api.dart';
import 'package:Me_Fuel/services/location.service.dart';
import 'package:Me_Fuel/stores/main_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:google_maps_webservice/places.dart' as places;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as mapLocation;
import 'package:Me_Fuel/models/GasStation.dart';


import 'package:flutter/services.dart' show rootBundle;
import 'package:mobx/mobx.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';

import '../detailPage.dart';
import '../main.dart';


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
  late mapLocation.PermissionStatus _permissionGranted;
  final EControlAPI _api = EControlAPI();
  List<GasStation> _listGasStations = List.empty();
  Map<MarkerId, Marker> _markersMap = {};
  final key = "AIzaSyBGmu809RbXJiJ6sLz8wxlj_BLmY7Re8bI";
  late places.GoogleMapsPlaces _places;
  late GoogleGeocoding _geocoding;

  final store = getIt<MainStore>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _places = places.GoogleMapsPlaces(apiKey: key);
    _geocoding = GoogleGeocoding(key);
  }

  void _onMapCreated(GoogleMapController controller){
    _controller = controller;

    LocationService.determinePosition().then((l) {
      var longitude = l.longitude;
      var latitude = l.latitude;
      if (longitude != null && latitude != null) {

        _locationSubscription.pause();

        _controller.animateCamera(
            CameraUpdate.newCameraPosition(
                CameraPosition(target: LatLng(latitude, longitude), zoom: 14)
            )
        );

        store.getGasStationsAtCurrentLocation();
        /*queryGasStationsForMap(latitude, longitude).then((value) {
          addMarkerToList(value);
        });*/

        store.gasStations.isNotEmpty ? addMarkerToList(store.gasStations) : print("No gasstations found");
      }
    });

    setLocationChangedListener((l) {



    });


    //_locationSubscription = _location.onLocationChanged.listen();

  }




  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search for location ...'),
        actions: [
          IconButton(
            onPressed: () async {
             places.Prediction? p = await PlacesAutocomplete.show(context: context, apiKey: key,
                 types: ["(cities)"], components: [places.Component(places.Component.country, "aut")], strictbounds: false);

             displayPrediction(p);

            },
            icon: Icon(Icons.search),
          ),
        ]
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: getInitialCameraPosition(),
        markers: Set.of(_markersMap.values),
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
      ),
    );
  }

  Future<Null> displayPrediction(places.Prediction? prediction) async {
    String? placeId = prediction?.placeId;
    if (prediction != null && placeId != null) {
      var detail = await _places.getDetailsByPlaceId(placeId);
      var lat = detail.result.geometry?.location.lat;
      var long = detail.result.geometry?.location.lng;

      var address = await _geocoding.geocoding.getReverse(LatLon(lat!, long!));

      _controller.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 14))
      );

      queryGasStationsForMap(lat, long).then((stations) {
        addMarkerToList(stations);
      });

      print(lat);
      print(long);
    }
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
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return DetailPage(
                    name: gasStation.name
                        .toString(),
                    price: gasStation.prices.toString(),
                    distance: gasStation.distance!
                        .toString(),
                  );
                })
              //MaterialPageRoute(builder: (context) => const DetailPage()),
            );
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
    if (_permissionGranted == mapLocation.PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != mapLocation.PermissionStatus.granted) {
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

