import 'package:http/http.dart' as http;
import 'dart:developer';

class RestService {
  static Future<String> get(String baseUri, String path, Map<String, String> parameter) {
    var uri = Uri.https(baseUri, path, parameter);
    return http.get(uri)
        .then((http.Response response) {
          if(response.statusCode >= 200 && response.statusCode < 300) {
            // TODO Uncomment (only for debug purpose)
            //log(response.body);
            return response.body;
          }
          return throw Exception("Error fetching data!");
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
