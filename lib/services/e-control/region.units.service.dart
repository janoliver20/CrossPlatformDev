import 'package:Me_Fuel/models/RegionUnit.dart';
import 'package:Me_Fuel/services/e-control/api.service.dart';

class RegionUnitService extends ApiService {
  RegionUnitService(String basePath): super(basePath, "/regions/units");

  Future<RegionUnit> getRegionUnits() {
    return fetchData({}, null)
        .then((Map<String, dynamic> json) => RegionUnit.fromJson(json));
  }
}