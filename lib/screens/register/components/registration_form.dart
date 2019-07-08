import 'package:flutter/material.dart';

import 'package:validators/validators.dart';
import 'package:validators/sanitizers.dart';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class RegistrationForm extends StatefulWidget {
  @override
  RegistrationFormState createState() {
    return RegistrationFormState();
  }
}

class RegistrationFormState extends State<RegistrationForm> {

  final _formKey = GlobalKey<FormState>();

  // Show and hide password
  bool _isHidden = true;
  void _toggleVisibility(){
    setState(() {
      _isHidden = !_isHidden;
    });
  }


  // Select major
  List<String> added = [];

  String currentText = "";

  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  List<String> suggestions = [
    "Computer Science",
    "Computer Engineering",
    "Mechanical Engineering",
    "Chemical Engineering",
    "Aerospace Engineering",
    "Civil Engineering",
    "Electrical Engineering"
  ];

  // Graduation year dropdown
  List _grad_years = ['2020', '2021', '2022', '2023'];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentGradYear;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentGradYear = _dropDownMenuItems[0].value;
    super.initState();
  }

  void changedDropDownItem(String selectedGradYear) {
    setState(() {
      _currentGradYear = selectedGradYear;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = List();
    for (String grad_year in _grad_years) {
      items.add(DropdownMenuItem(
          value: grad_year,
          child: Text(grad_year)
      ));
    }
    return items;
  }

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
            Padding(padding: EdgeInsets.only(top: 40.0)),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter First Name',
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(),
                ),
              ),
              validator: (firstName) {
                // Sanitize the input
                firstName = trim(firstName);

                // Validate input
                if (firstName.length > 50) {
                  return 'First name must be under 50 characters.';
                }
                if (firstName.isEmpty) {
                  return 'Enter some text';
                }

                firstName = '${firstName[0].toUpperCase()}${firstName.substring(1)}';

                return null;
              },
            ),
            Padding(padding: EdgeInsets.only(top: 15.0)),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter Last Name',
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(),
                ),
              ),
              validator: (lastName) {
                // Sanitize the input
                lastName = trim(lastName);

                // Validate input
                if (lastName.length > 50) {
                  return 'First name must be under 50 characters.';
                }
                if (lastName.isEmpty) {
                  return 'Enter some text';
                }

                lastName = '${lastName[0].toUpperCase()}${lastName.substring(1)}';
              },
            ),
            Padding(padding: EdgeInsets.only(top: 15.0)),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter Email',
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(),
                ),
              ),
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
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter some text';
                }
                return null;
              },
            ),
            Padding(padding: EdgeInsets.only(top: 15.0)),
            SimpleAutoCompleteTextField(
              key: key,
              decoration: InputDecoration(
                labelText: 'Enter Major',
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(),
                ),
              ),
              controller: TextEditingController(text: ""),
              suggestions: suggestions,
              textChanged: (text) => currentText = text,
              clearOnSubmit: false,
              textSubmitted: (text) => setState(() {
                if (text != "") {
                  added.add(text);
                }
              })
            ),
            Padding(padding: EdgeInsets.only(top: 15.0)),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Graduation Year: ',
                    style: TextStyle(color: Colors.blue, fontSize: 20.0)
                  ),
                  DropdownButton(
                      value: _currentGradYear,
                      items: _dropDownMenuItems,
                      onChanged: changedDropDownItem,
                  ),
                ]
              ),
            ),
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