import 'package:flutter/material.dart';
import 'package:aris_frontend/screens/login/components/login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: LoginForm(),
    );
  }
}