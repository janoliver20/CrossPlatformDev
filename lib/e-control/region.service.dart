class RegionService {
  String _apiPath = "localhost";
  final _regionPath = "/regions";
  final _unitPath = "/units";

  RegionService(String basePath) {
    _apiPath = basePath + _regionPath;
  }



}