import 'package:flutter/material.dart';
import 'package:aris_frontend/screens/feedback/components/feedback_form.dart';


class FeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send Feedback"),
      ),
      body: FeedbackForm(),
    );
  }
}