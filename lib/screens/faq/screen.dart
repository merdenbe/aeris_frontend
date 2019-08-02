import 'package:flutter/material.dart';
import 'package:validators/sanitizers.dart';
import 'package:aris_frontend/services/getQuestions.dart';
import 'package:aris_frontend/services/poseQuestion.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FAQScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return FAQScreenState();
  }
}

class FAQScreenState extends State<FAQScreen>{

  List<Map<String, String>> questions = [];

  TextEditingController questionController = TextEditingController();

  String myToken = '';

  loadQuestions() {
    getQuestions().then((List<Map<String, String>> questions) {
      setState(() {
        this.questions = questions;
      });
    });
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      myToken = prefs.getString('token');
    });
  }

  void initState() {
    super.initState();
    loadQuestions();
    getToken();
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('New Question'),
          content: TextFormField(
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Enter question here...',
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(),
              ),
            ),
            controller: questionController,
            keyboardAppearance: Brightness.light,
            validator: (feedback) {
              // Sanitize the input
              feedback = trim(feedback);

              // Validate input
              if (feedback.isEmpty) {
                return 'Enter some text';
              }
              if (feedback.length > 512) {
                return 'Feedback must be under 512 characters.';
              }
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel', style: TextStyle(color: Colors.red)),
              onPressed: () {
                questionController.clear();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Submit', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                // Validate input
                String question = trim(questionController.text);
                if (question.isEmpty || question.length > 512) {
                  questionController.clear();
                  Navigator.of(context).pop();
                }

                // Submit question
                var body = json.encode({
                  'question': question,
                  'user_email': "merdenbe@nd.edu"
                });
                poseQuestion("https://aris-backend-staging.herokuapp.com/questions", body, myToken).then((int statusCode) {
                  print(statusCode);
                  Navigator.of(context).pop();
                });
              },
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("FAQ"),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(questions[index]["content"]),
                subtitle: Text(questions[index]["answer"]),
              )
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xff390D58),
        icon: Icon(Icons.add),
        label: Text('Ask New Question'),
        onPressed: () => _displayDialog(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Padding(padding: EdgeInsets.only(top: 35.0)),
      )
    );
  }
}