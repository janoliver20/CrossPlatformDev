import 'dart:async';

import 'dart:io' show Platform;
import 'package:Me_Fuel/screens/DetailScreen.dart';
import 'package:Me_Fuel/services/location.service.dart';
import 'package:Me_Fuel/stores/main_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_webservice/places.dart' as places;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:Me_Fuel/models/GasStation.dart';
import 'package:permission_handler/permission_handler.dart' as pm;
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import '../Strings.dart';
import '../main.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => MapScreenState();

}

class MapScreenState extends State<MapScreen> {

  static const CameraPosition defaultPosition = CameraPosition(target: LatLng(48.36784132608749, 14.514988624961328), zoom: 14);
  final Map<MarkerId, Marker> _markersMap = {};
  final key = "AIzaSyBGmu809RbXJiJ6sLz8wxlj_BLmY7Re8bI";
  late places.GoogleMapsPlaces _places;
  late GoogleMapController _controller;
  bool _navigationButtonEnabled = false;
  GasStation? _selectedGasStation;
  final store = getIt<MainStore>();

  @override
  void initState() {
    super.initState();
    _places = places.GoogleMapsPlaces(apiKey: key);
  }

  void _onMapCreated(GoogleMapController controller){
    _controller = controller;

    LocationService.determinePosition().then((l) {
      var longitude = l.longitude;
      var latitude = l.latitude;

      _controller.animateCamera(
          CameraUpdate.newCameraPosition(
              CameraPosition(target: LatLng(latitude, longitude), zoom: 12.5)
          )
      );

      store.getGasStationsAtCurrentLocation();

    }).onError((error, stackTrace) {
      showDialog(context: context, builder: (context) => AlertDialog(
        title: const Text(Strings.map_location_required_title),
        content: const Text(Strings.map_location_required_content),
        actions: [
          TextButton(onPressed: () {
            pm.openAppSettings();
          }, child: const Text(Strings.map_location_required_opensettings))
        ],
      ),
      barrierDismissible: false);
    });
  }

void _onCameraMove(CameraPosition position) {

    var cameraPosition = position.target;
    if (position.zoom >= 10){
      store.getGasStationAtLocation(cameraPosition.latitude, cameraPosition.longitude);
    }

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.map_appbar_tite),
        actions: [
          IconButton(
            onPressed: () async {
             places.Prediction? p = await PlacesAutocomplete.show(context: context, apiKey: key,
                 types: ["(cities)"], components: [places.Component(places.Component.country, "aut")], strictbounds: false);

             displayPrediction(p);

            },
            icon: const Icon(Icons.search),
          ),
        ]
      ),
      body: Observer(builder: (_) {
        store.gasStations.isNotEmpty ? addMarkerToList(store.gasStations) : print(Strings.list_no_result);
        return Stack(
          children: <Widget>[
            GoogleMap(
            mapType: MapType.normal,
              initialCameraPosition: getInitialCameraPosition(),
              markers: Set.of(_markersMap.values),
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              onCameraMove: _onCameraMove,
              mapToolbarEnabled: true,
              onTap: (_) {
                setState(() {
                  _selectedGasStation = null;
                  _navigationButtonEnabled = false;
                });
              },
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Visibility(
                    visible: _navigationButtonEnabled && Platform.isIOS,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 80, right: 10),
                      child: FloatingActionButton(
                        onPressed: _navigationButtonEnabled ? () {
                          openMap(_selectedGasStation!.location.latitude, _selectedGasStation!.location.longitude);
                        } : null,
                        child: const Icon(Icons.navigation),
                      ),
                    )
                )
            )
          ],
        );
      }),
    );
  }

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'comgooglemaps://?daddr=$latitude,$longitude';
    String appleMapsUrl = 'http://maps.apple.com/?daddr=$latitude,$longitude&dirflg=d&t=h';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else if (await canLaunch(appleMapsUrl)) {
      await launch(appleMapsUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  Future<Null> displayPrediction(places.Prediction? prediction) async {
    String? placeId = prediction?.placeId;
    if (prediction != null && placeId != null) {
      var detail = await _places.getDetailsByPlaceId(placeId);
      var lat = detail.result.geometry?.location.lat;
      var long = detail.result.geometry?.location.lng;
      
      if (lat != null && long != null) {
        _controller.animateCamera(
            CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 14))
        );

        store.getGasStationAtLocation(lat, long, listOption: GasStationListOperationOption.append);
      }
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

    if (_markersMap.containsKey(markerId)) {
      return;
    }

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
                  return DetailScreen(gasStation: gasStation);
                })
            );
          },
        ),
        icon: getBitmapDescriptor(customMarkerImage),
      onTap: () {
          setState(() {
            _selectedGasStation = gasStation;
            _navigationButtonEnabled = true;
          });
      },

    );

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

    LocationService.determinePosition().then((l) {
      var latitude = l.latitude;
      var longitude = l.longitude;

      return CameraPosition(target: LatLng(latitude,longitude), zoom: 14);
    });

    return defaultPosition;
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

