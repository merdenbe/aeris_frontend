import 'package:flutter/material.dart';
import 'package:aris_frontend/screens/register/components/registrationForm.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: RegistrationForm(),
    );
  }
}