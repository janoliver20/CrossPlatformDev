import 'package:Me_Fuel/models/Region.dart';
import 'api.service.dart';

class RegionService extends ApiService {

  RegionService(String basePath) : super(basePath, "/regions");

  Future<List<Region>> getRegions({includeCities = true}) {
    return fetchData({"includeCities": includeCities}, null)
        .then((json) => regionFromJson(json));
  }
}