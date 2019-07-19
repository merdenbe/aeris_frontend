import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<Post> fetchPost() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');

  final response = await http.get('https://aris-backend-staging.herokuapp.com/course_requests', headers: {'Authorization': 'Bearer ${token}'});

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final List<String> requested_courses;

  Post({this.requested_courses});

  factory Post.fromJson(Map<String, dynamic> json) {
    List<String> c = [];
    for (String requested_course in json['requested_courses']) {
        c.add(requested_course);
    }
    return Post(requested_courses: c);
  }
}