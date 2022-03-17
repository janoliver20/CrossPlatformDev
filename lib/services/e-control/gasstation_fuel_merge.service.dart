import 'dart:core';

import 'package:Me_Fuel/services/e-control/gasstations.service.dart';

import '../../models/GasStation.dart';
import '../../models/Region.dart';

class GasStationFuelMerge extends GasStationService {
  GasStationFuelMerge(String basePath) : super(basePath);

  @override
  Future<List<GasStation>> getByAddress({required double latitude, required double longitude, required FuelType fuelType, includeClosed = false}) {
    var multipleFutures = RegionType.values
        .map((regionType) => super
        .getByAddress(latitude: latitude, longitude: longitude, fuelType: fuelType, includeClosed: includeClosed));
    return Future.wait(multipleFutures)
        .then((lists) {
          return _mergeGasStations(lists);
        });
  }

  @override
  Future<List<GasStation>> getByRegion({required String code, required RegionType regionType, required FuelType fuelType, includeClosed = false}) {
    var multipleFutures = RegionType.values
        .map((regionType) => super
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