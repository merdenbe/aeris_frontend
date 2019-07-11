import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Post> fetchPost() async {
  final response =
      await http.get('https://aris-backend-staging.herokuapp.com/majors');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final List<String> majors;

  Post({this.majors});

  factory Post.fromJson(Map<String, dynamic> json) {
    List<String> m = [];
    for (String major in json['majors']) {
        m.add(major);
    }
    return Post(majors: m);
  }
}

