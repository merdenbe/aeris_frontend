import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TutorInfo {
  String firstName;
  String lastName;
  String phoneNumber;

  TutorInfo(String firstName, String lastName, String phoneNumber) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.phoneNumber = phoneNumber;
  }
}


Future<TutorInfo> findTutor(String body) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  final response = await http.post('https://aris-backend-staging.herokuapp.com/find_tutor', body: body, headers: {'Authorization': 'Bearer ${token}'});

  if (response.statusCode == 200) {
    dynamic body = json.decode(response.body);

    // Set session_id
    prefs.setInt('session_id', body["session_id"]);

    // Return tutor_info
    TutorInfo t = TutorInfo(body["first_name"], body["last_name"], body["phone_number"]);
    return t;
  } else {
    return TutorInfo("Error", "No tutors available", "No phone");
  }
}