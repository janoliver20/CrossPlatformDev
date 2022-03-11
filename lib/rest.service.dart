import 'package:http/http.dart' as http;

class RestService {
  static Future<http.Response> get(String baseUri, String path, Map<String, dynamic> parameter) => http.get(Uri.https(baseUri, path, parameter));
}
