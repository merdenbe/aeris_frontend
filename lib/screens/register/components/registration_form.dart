import 'package:flutter/material.dart';
import 'package:aris_frontend/screens/register/components/grad_year_dropdown.dart';
import 'package:aris_frontend/screens/register/components/password_textfield.dart';
import 'package:aris_frontend/screens/register/components/select_major.dart';
import 'package:aris_frontend/screens/register/components/standard_text_field.dart';

class RegistrationForm extends StatefulWidget {
  @override
  RegistrationFormState createState() {
    return RegistrationFormState();
  }
}

class RegistrationFormState extends State<RegistrationForm> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(35.0),
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 40.0)),
            Text(
              'Sign Up',
              style: new TextStyle(color: Colors.blue, fontSize: 25.0)
            ),
            Padding(padding: EdgeInsets.only(top: 45.0)),
            StandardTextField(title: 'First Name'),
            Padding(padding: EdgeInsets.only(top: 15.0)),
            StandardTextField(title: 'Last Name'),
            Padding(padding: EdgeInsets.only(top: 15.0)),
            StandardTextField(title: 'Email'),
            Padding(padding: EdgeInsets.only(top: 15.0)),
            PasswordTextField(),
            Padding(padding: EdgeInsets.only(top: 15.0)),
            SelectMajorDropdown(),
            Padding(padding: EdgeInsets.only(top: 15.0)),
            GradYearDropDown(),
            Padding(padding: EdgeInsets.only(top: 60.0)),
            Align(
              alignment: Alignment.bottomRight,
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                  }
                },
                child: Text('Create Account', style: TextStyle(fontSize: 17.0))
              )
            )
          ],
        ),
      )
    );
  }
}