import 'dart:core';

import 'package:Me_Fuel/services/e-control/gasstations.service.dart';

import '../../models/GasStation.dart';
import '../../models/Region.dart';

class GasStationFuelMerge extends GasStationService {
  GasStationFuelMerge(String basePath) : super(basePath);

  Future<List<GasStation>> getAllFuelTypesByAddress({required double latitude, required double longitude, includeClosed = false}) {
    var multipleFutures = FuelType.values
        .map((fuelType) => super
        .getByAddress(latitude: latitude, longitude: longitude, fuelType: fuelType, includeClosed: includeClosed));
    return Future.wait(multipleFutures)
        .then((lists) {
          return _mergeGasStations(lists);
        });
  }

  Future<List<GasStation>> getAllFuelTypesByRegion({required String code, required RegionType regionType, includeClosed = false}) {
    var multipleFutures = FuelType.values
        .map((fuelType) => super
        .getByRegion(code: code, regionType: regionType, fuelType: fuelType, includeClosed: includeClosed));
    return Future.wait(multipleFutures)
        .then((lists) {
      return _mergeGasStations(lists);
    });
  }

  List<GasStation> _mergeGasStations(List<List<GasStation>> lists) {
    if (lists.isNotEmpty) {
      return lists.reduce((old, stations) {
        for (var gasStation in stations) {
          var index = old
              .indexWhere((oldStation) => oldStation.id == gasStation.id);
          if (index >= 0) {
            var oldPrice = old[index].prices;
            if (!oldPrice
                .any((price) => gasStation.prices
                .any((newPrice) => price.fuelType == newPrice.fuelType))) {
              old[index].prices = [...oldPrice, ...gasStation.prices];
            }
          } else {
            old.add(gasStation);
          }
        }
        return old;
      });
    }
    return [];
  }

}