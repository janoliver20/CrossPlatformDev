import 'package:http/http.dart' as http;
import 'dart:developer';

class RestService {
  static Future<String> get(String baseUri, String path, Map<String, dynamic> parameter) {
    return http.get(Uri.https(baseUri, path, parameter))
        .then((http.Response response) {
          if(response.statusCode >= 200 && response.statusCode < 300) {
            return response.body;
          }
          throw Exception("Error fetching data!");
        },
        onError: (error) {
          log(error);
          throw error;
        })
        .catchError((onError) {
          log(onError);
          throw onError;
        });
  }
}
