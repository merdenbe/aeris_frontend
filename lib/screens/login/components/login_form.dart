import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:validators/sanitizers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nice_button/nice_button.dart';
import 'package:flutter/gestures.dart';
import 'dart:convert';
import 'package:aris_frontend/services/login.dart';

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Show and hide password
  bool _isHidden = true;
  void _toggleVisibility(){
    setState(() {
      _isHidden = !_isHidden;
    });
  }



  storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
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
              Padding(padding: EdgeInsets.only(top: 125.0)),
              Text(
                'Login',
                style: new TextStyle(color: Colors.blue, fontSize: 25.0)
              ),
              Padding(padding: EdgeInsets.only(top: 100.0)),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Email',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(),
                  ),
                ),
                controller: emailController,
                validator: (email) {
                  // Sanitization
                  email = trim(email);

                  // Validation
                  if (!isEmail(email)) {
                    return "Enter a valid email.";
                  }
                  if (email.substring(email.length - 6) != "nd.edu") {
                    return "Must use a Notre Dame email.";
                  }
                  if (email.isEmpty) {
                    return 'Enter some text';
                  }

                  return null;
                },
              ),
              Padding(padding: EdgeInsets.only(top: 15.0)),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                      onPressed: _toggleVisibility,
                      icon: _isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(),
                  ),
                ),
                obscureText: _isHidden,
                controller: passwordController,
                validator: (password) {
                  // Sanitize input
                  password = trim(password);

                  // Validate Password
                  if (password.length < 8) {
                    return 'Password must be at least 8 characters.';
                  }
                  if (password.length > 50) {
                    return 'Password must be less than 50 characters.';
                  }

                  RegExp regexNumber = RegExp(r'[0-9]+');
                  if (!regexNumber.hasMatch(password)) {
                    return 'Password must contain at least one number';
                  }

                  RegExp regexCapital = RegExp(r'[A-Z]+');
                  if (!regexCapital.hasMatch(password)) {
                    return 'Password must contain at least one capital letter.';
                  }

                  return null;
                },
              ),
              Padding(padding: EdgeInsets.only(top: 75.0)),
              NiceButton(
                width: 400,
                elevation: 8,
                radius: 52,
                padding: const EdgeInsets.all(10),
                text: "Login",
                gradientColors: [Color(0xff5b86e5), Color(0xff36d1dc)],
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Logging in...'), backgroundColor: Colors.blue,));
                    var body= json.encode({
                      'email': emailController.text,
                      'password': passwordController.text,
                    });
                    login("https://aris-backend-staging.herokuapp.com/reauthenticate", body).then((String token) {
                      if (token == "error") {
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Incorrect username/password combination.'), backgroundColor: Colors.red,));
                        return;
                      } else {
                        storeToken(token);
                        Navigator.pushNamed(context, '/home');
                      }
                    });
                  }
                },
              ),
              Padding(padding: EdgeInsets.only(top: 15.0)),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Don\'t have an account?  ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Sign Up!',
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, '/register');
                      },
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
      )
    );
  }
}