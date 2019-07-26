import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Response {
  int statusCode;
  String title;
  String description;
  double coupon_value;
  double updated_balance;

  Response(int statusCode, String title, String description, double coupon_value, double updated_balance) {
    this.statusCode = statusCode;
    this.title = title;
    this.description = description;
    this.coupon_value = coupon_value;
    this.updated_balance = updated_balance;
  }
}

Future<Response> redeemCoupon(String url, String body, String token) async {
  return http.put(url, body: body, headers: {'Authorization': 'Bearer ${token}'}).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (json == null) {
      throw new Exception("Error while fetching data");
    }
    Map<String, dynamic> resp = json.decode(response.body);

    return Response(statusCode, resp["title"], resp["description"], resp["coupon_value"], resp["updated_balance"]);
  });
}