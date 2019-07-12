import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> login(String url, String body) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      return "error";
    }
    return json.decode(response.body)['token'];
  });
}