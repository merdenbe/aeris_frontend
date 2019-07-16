import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<int> submitFeedback(String url, String body) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return statusCode;
  });
}