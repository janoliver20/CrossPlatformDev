import 'package:Me_Fuel/models/GasStation.dart';
import 'package:Me_Fuel/models/Region.dart';
import 'package:Me_Fuel/services/e-control/api.service.dart';

class GasStationService extends ApiService {
  GasStationService(String basePath): super(basePath, "/gas-stations");

  Future<GasStation> getByAddress({required double latitude, required double longitude, required FuelType fuelType, includeClosed = false}) {
    return fetchData({"latitude": latitude, "longitude": longitude, "fuelType": getFuelType(fuelType), "includeClosed": includeClosed}, "/by-address")
        .then((Map<String, dynamic> json) => GasStation.fromJson(json));
  }

  Future<GasStation> getByRegion({required String code, required RegionType regionType, required FuelType fuelType, includeClosed = false}) {
    return fetchData({"code": code, "type": getRegionType(regionType), "fuelType": getFuelType(fuelType), "includeClosed": includeClosed}, "/by-region")
        .then((Map<String, dynamic> json) => GasStation.fromJson(json));
  }
}

