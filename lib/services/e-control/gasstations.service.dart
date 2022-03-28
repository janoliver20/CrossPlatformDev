import 'package:Me_Fuel/models/GasStation.dart';
import 'package:Me_Fuel/models/Region.dart';
import 'package:Me_Fuel/services/e-control/api.service.dart';

class GasStationService extends ApiService {
  GasStationService(String baseUri, String basePath): super(baseUri, basePath + "/search/gas-stations");

  Future<List<GasStation>> getByAddress({required double latitude, required double longitude, required FuelType fuelType, includeClosed = false}) {
    return fetchData({"latitude": latitude, "longitude": longitude, "fuelType": getFuelType(fuelType), "includeClosed": includeClosed}, "/by-address")
        .then((json) => gasStationFromJson(json));
  }

  Future<List<GasStation>> getByRegion({required int code, required RegionType regionType, required FuelType fuelType, includeClosed = false}) {
    return fetchData({"code": code, "type": getRegionType(regionType), "fuelType": getFuelType(fuelType), "includeClosed": includeClosed}, "/by-region")
        .then((json) => gasStationFromJson(json));
  }
}

