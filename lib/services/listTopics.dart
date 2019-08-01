import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Topic {
  String name;
  int id;

  Topic(String name, int id) {
    this.name = name;
    this.id = id;
  }
}

Future<List<Topic>> listTopics() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  final response = await http.get('https://aris-backend-staging.herokuapp.com/topics/1', headers: {'Authorization': 'Bearer ${token}'});

  if (response.statusCode == 200) {
    dynamic body = json.decode(response.body);

    List<Topic> topics = [];
    for (Map<String, dynamic> topic in body["topics"]) {
      Topic t = Topic(topic["name"], topic["id"]);
      topics.add(t);
    }

    return topics;
  } else {
    throw Exception('Failed to load questions');
  }
}