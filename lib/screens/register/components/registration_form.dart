import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:validators/sanitizers.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:aris_frontend/services/listmajors.dart';
import 'package:aris_frontend/services/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nice_button/nice_button.dart';
import 'dart:convert';

class RegistrationForm extends StatefulWidget {
  @override
  RegistrationFormState createState() {
    return RegistrationFormState();
  }
}

class RegistrationFormState extends State<RegistrationForm> {

  final _formKey = GlobalKey<FormState>();

  // Textfield Controllers
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
  GlobalKey<AutoCompleteTextFieldState<String>> key2 = GlobalKey();
  TextEditingController majorController = TextEditingController(text: "");
  Future<Post> post;
  List<String> majors = [];

  // Graduation year dropdown
  List _grad_years = ['2020', '2021', '2022', '2023'];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentGradYear;

  @override
  void initState() {
    super.initState();
    _dropDownMenuItems = getDropDownMenuItems();
    _currentGradYear = _dropDownMenuItems[0].value;
    post = fetchPost();
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

  setProfile(String name, String major, String gradYear, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('major', major);
    await prefs.setString('gradYear', gradYear);
    await prefs.setString('token', token);
    await prefs.setBool('isRegistered', true);
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
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Text(
                'Sign Up',
                style: TextStyle(color: Color(0xff390D58), fontSize: 25.0)
              ),
              Padding(padding: EdgeInsets.only(top: 30.0)),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter First Name',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(),
                  ),
                ),
                keyboardAppearance: Brightness.light,
                controller: firstNameController,
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
                keyboardAppearance: Brightness.light,
                controller: lastNameController,
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
                keyboardType: TextInputType.emailAddress,
                keyboardAppearance: Brightness.light,
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
                keyboardAppearance: Brightness.light,
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
              Padding(padding: EdgeInsets.only(top: 15.0)),
              FutureBuilder<Post>(
                future: post,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    majors = snapshot.data.majors;
                    return SimpleAutoCompleteTextField(
                              key: key,
                              decoration: InputDecoration(
                                labelText: 'Enter Major',
                                errorText: null,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(),
                                ),
                              ),
                              controller: majorController,
                              suggestions: snapshot.data.majors,
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
                                labelText: 'Enter Major',
                                errorText: null,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(),
                                ),
                              ),
                              controller: TextEditingController(text: ""),
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
              Padding(padding: EdgeInsets.only(top: 15.0)),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Graduation Year: ',
                      style: TextStyle(color: Color(0xff390D58), fontSize: 20.0)
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
              NiceButton(
                width: 400,
                elevation: 8,
                radius: 52,
                padding: const EdgeInsets.all(10),
                text: "Create Account",
                gradientColors: [Color(0xff390D58), Colors.purpleAccent],
                onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // Test if major was picked from list
                      if (!majors.contains(currentText)) {
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Select a major from the list.'), backgroundColor: Colors.red,));
                        return;
                      }
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Creating account...'), backgroundColor: Colors.green,));
                      var body= json.encode({
                        'firstName': firstNameController.text,
                        'lastName': lastNameController.text,
                        'email': emailController.text,
                        'password': passwordController.text,
                        'gradYear': _currentGradYear,
                        'major': currentText
                      });
                      register("https://aris-backend-staging.herokuapp.com/register", body).then((String token) {
                        setProfile("${firstNameController.text} ${lastNameController.text}", currentText, _currentGradYear, token);
                      });
                      Navigator.pushNamed(context, '/home');
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