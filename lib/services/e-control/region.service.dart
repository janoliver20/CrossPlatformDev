import 'package:Me_Fuel/models/Region.dart';
import 'api.service.dart';

class RegionService extends ApiService {

  RegionService(String basePath) : super(basePath, "/regions");

  Future<Region> getRegions({includeCities = true}) {
    return fetchData({"includeCities": includeCities}, null)
        .then((Map<String, dynamic> json) => Region.fromJson(json));
  }

}