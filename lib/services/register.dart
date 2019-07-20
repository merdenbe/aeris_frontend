import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterResponse {
  String token;
  int account_id;

  RegisterResponse(String token, int account_id) {
    this.token = token;
    this.account_id = account_id;
  }
}

Future<RegisterResponse> register(String url, String body) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }

    var body = json.decode(response.body);
    var resp = RegisterResponse(body['token'], body['account_id']);

    return resp;
  });
}