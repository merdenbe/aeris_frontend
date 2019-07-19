import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:aris_frontend/services/list_course_requests.dart';
import 'package:nice_button/nice_button.dart';
import 'package:validators/sanitizers.dart';
import 'package:aris_frontend/services/request_course.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CourseRequestForm extends StatefulWidget {
  @override
  CourseRequestFormState createState() {
    return CourseRequestFormState();
  }
}

class CourseRequestFormState extends State<CourseRequestForm> {

  final _formKey = GlobalKey<FormState>();

  // Select major
  List<String> added = [];
  String currentText = "";
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> key2 = GlobalKey();
  Future<Post> post;
  List<String> requestedCourses = [];
  String myToken = '';

  @override
  void initState() {
    super.initState();
    getToken();
    post = fetchPost();
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      myToken = prefs.getString('token');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(35.0),
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 160.0)),
              Text(
                "Request the courses you want to see this app support.",
                style: TextStyle(
                  fontSize: 25.0,
                )
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              FutureBuilder<Post>(
                future: post,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    requestedCourses = snapshot.data.requested_courses;
                    return SimpleAutoCompleteTextField(
                              key: key,
                              decoration: InputDecoration(
                                labelText: 'Enter course name.',
                                errorText: null,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(),
                                ),
                              ),
                              suggestions: snapshot.data.requested_courses,
                              textChanged: (text) => currentText = text,
                              clearOnSubmit: false,
                              textSubmitted: (text) => setState(() {
                                currentText = text;
                              })
                            );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else {
                    return SimpleAutoCompleteTextField(
                              key: key2,
                              decoration: InputDecoration(
                                labelText: 'Enter course name.',
                                errorText: null,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(),
                                ),
                              ),
                              suggestions: ["loading..."],
                              textChanged: (text) => currentText = text,
                              clearOnSubmit: false,
                              textSubmitted: (text) => setState(() {
                                currentText = text;
                              })
                            );
                  }
                }
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              NiceButton(
                width: 400,
                elevation: 8,
                radius: 52,
                padding: const EdgeInsets.all(10),
                text: "Request",
                gradientColors: [Color(0xff5b86e5), Color(0xff36d1dc)],
                onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // Validate length
                      currentText = trim(currentText);
                      if (currentText.length > 256) {
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Course name must be under 256 characters.'), backgroundColor: Colors.red,));
                        return;
                      } else if (currentText.isEmpty) {
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Enter a course name first.'), backgroundColor: Colors.red,));
                        return;
                      }
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Request sent.'), backgroundColor: Colors.green,));
                      var body= json.encode({
                        'title': currentText,
                        'account_id': "1",
                      });
                      requestCourse("https://aris-backend-staging.herokuapp.com/course_requests", body, myToken).then((int statusCode) {
                        print(statusCode);
                      });
                    }
                  }
              ),
            ],
          ),
        ),
      )
    );
  }
}