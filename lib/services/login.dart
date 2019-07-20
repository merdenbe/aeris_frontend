import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginResponse {
  String token;
  int account_id;

  LoginResponse(String token, int account_id) {
    this.token = token;
    this.account_id = account_id;
  }
}

Future<LoginResponse> login(String url, String body) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      return LoginResponse('error', 0);
    }

    var body = json.decode(response.body);
    var resp = LoginResponse(body['token'], body['account_id']);

    return resp;
  });
}