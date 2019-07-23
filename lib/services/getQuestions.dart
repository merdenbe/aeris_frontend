import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<List<Map<String, String>>> getQuestions() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  final response = await http.get('https://aris-backend-staging.herokuapp.com/questions', headers: {'Authorization': 'Bearer ${token}'});

  if (response.statusCode == 200) {
    dynamic body = json.decode(response.body);

    List<Map<String, String>> questions = [];
    for (Map<String, dynamic> question in body["questions"]) {
      String c = question["question"];
      String a = question["answer"];
      questions.add({"content": c, "answer": a});
    }

    return questions;
  } else {
    throw Exception('Failed to load questions');
  }
}