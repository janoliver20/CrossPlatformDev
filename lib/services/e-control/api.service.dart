import 'dart:convert';

import 'package:Me_Fuel/services/rest.service.dart';

abstract class ApiService {
  String _basePath = "localhost";
  String _apiPath = "";

  ApiService(String basePath, String path) {
    _basePath = basePath;
    _apiPath = path;
  }

  Future<Map<String, dynamic>> fetchData(Map<String, dynamic> parameters, String? extraPath)
  {
    return RestService.get(_basePath, _apiPath, parameters).then((String response) => jsonDecode(response));
  }
}