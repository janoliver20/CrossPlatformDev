import 'package:Me_Fuel/models/GasStation.dart';
import 'package:Me_Fuel/models/Region.dart';
import 'package:Me_Fuel/models/RegionUnit.dart';
import 'package:Me_Fuel/services/e-control/gasstation_fuel_merge.service.dart';
import 'package:Me_Fuel/services/e-control/region.service.dart';

class EControlAPI {
  final RegionService _regionService;
  final GasStationFuelMerge _gasStationService;
  EControlAPI(basePath):
        _regionService = RegionService(basePath),
        _gasStationService = GasStationFuelMerge(basePath);

  Future<List<Region>> queryRegions({includeCities = true}) {
    return _regionService.getRegions(includeCities: includeCities);
  }

  Future<List<RegionUnit>> queryRegionUnits() {
    return _regionService.getRegionUnits();
  }

  Future<List<GasStation>> queryGasStationsByAddress({required double latitude, required double longitude, includeClosed = false, FuelType? fuelType}) {
    if (fuelType != null) {
      return _gasStationService.getByAddress(latitude: latitude, longitude: longitude, fuelType: fuelType, includeClosed: includeClosed);
    }
    return _gasStationService.getAllFuelTypesByAddress(latitude: latitude, longitude: longitude, includeClosed: includeClosed);
  }

  Future<List<GasStation>> queryGasStationsByRegion({required String code, required RegionType regionType, includeClosed = false, FuelType? fuelType}) {
    if (fuelType != null) {
      return _gasStationService.getByRegion(code: code, regionType: regionType, fuelType: fuelType, includeClosed: includeClosed);
    }
    return _gasStationService.getAllFuelTypesByRegion(code: code, regionType: regionType, includeClosed: includeClosed);
  }


}