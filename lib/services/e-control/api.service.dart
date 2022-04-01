import 'dart:convert';

import 'package:Me_Fuel/services/rest.service.dart';

abstract class ApiService {
  String _baseUri = "localhost";
  String _apiPath = "";

  ApiService(String baseUri, String path) {
    _baseUri = baseUri;
    _apiPath = path;
  }

  Future<String> fetchData(Map<String, dynamic> parameters, String? extraPath)
  {
    var param = parameters.map((key, value) => MapEntry(key, value.toString()));
    return RestService.get(_baseUri, _apiPath + (extraPath ?? ""), param);
  }
}