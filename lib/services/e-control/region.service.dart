import 'package:Me_Fuel/models/Region.dart';
import '../../models/RegionUnit.dart';
import 'api.service.dart';

class RegionService extends ApiService {

  RegionService(String baseUri, String basePath) : super(baseUri, basePath + "/regions");

  Future<List<Region>> getRegions({includeCities = false}) {
    return fetchData({"includeCities": includeCities}, null)
        .then((json) => regionFromJson(json));
  }

  Future<List<RegionUnit>> getRegionUnits() {
    return fetchData({}, "/units")
        .then((json) => regionUnitFromJson(json));
  }
}