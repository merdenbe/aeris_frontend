import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';
import 'package:validators/sanitizers.dart';
import 'package:aris_frontend/services/submitFeedback.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FeedbackForm extends StatefulWidget {
  @override
  FeedbackFormState createState() {
    return FeedbackFormState();
  }
}

class FeedbackFormState extends State<FeedbackForm> {

  final _formKey = GlobalKey<FormState>();

  String myToken = '';

  TextEditingController feedbackController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getToken();
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
              Text(
                "Your feedback is vital to building this app. Tell us what you like, dislike, and want to see out of this app.",
                style: TextStyle(
                  fontSize: 20.0,
                )
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              TextFormField(
                maxLines: 20,
                decoration: InputDecoration(
                  hintText: 'Enter feedback here...',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(),
                  ),
                ),
                controller: feedbackController,
                keyboardAppearance: Brightness.light,
                validator: (feedback) {
                  // Sanitize the input
                  feedback = trim(feedback);

                  // Validate input
                  if (feedback.isEmpty) {
                    return 'Enter some text';
                  }
                  if (feedback.length > 2048) {
                    return 'Feedback must be under 2048 characters.';
                  }
                },
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              NiceButton(
                width: 400,
                elevation: 8,
                radius: 52,
                padding: const EdgeInsets.all(10),
                text: "Submitt",
                gradientColors: [Color(0xff5b86e5), Color(0xff36d1dc)],
                onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Feedback submitted.'), backgroundColor: Colors.green,));
                      var body= json.encode({
                        'msg': feedbackController.text
                      });
                      submitFeedback("https://aris-backend-staging.herokuapp.com/feedback", body, myToken).then((int statusCode) {
                        print(statusCode);
                        Navigator.pushNamed(context, '/home');
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