import 'package:flutter/material.dart';
import 'package:validators/sanitizers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:aris_frontend/services/listmajors.dart';
import 'package:aris_frontend/services/editProfile.dart';
import 'dart:convert';

class EditProfileScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return EditProfileScreenState();
  }
}

class EditProfileScreenState extends State<EditProfileScreen>{

  final _formKey = GlobalKey<FormState>();

  // Textfield Controllers
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  // Token and account_id
  String myToken = '';
  String account_id = "10";

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

  getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String name = prefs.getString('name');
      firstNameController.text = name.split(" ")[0];
      lastNameController.text = name.split(" ")[1];
      this._currentGradYear = prefs.getString('gradYear');
      this.currentText = prefs.getString('major');
      majorController.text = prefs.getString("major");
      this.myToken = prefs.getString("token");
    });
  }

  void initState() {
    super.initState();
    _dropDownMenuItems = getDropDownMenuItems();
    _currentGradYear = _dropDownMenuItems[0].value;
    post = fetchPost();
    getProfile();
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
     return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(35.0),
            child: Column(
              children: <Widget>[
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
              ],
            ),
          ),
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        icon: Icon(Icons.save),
        label: Text('Save Changes'),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            // Test if major was picked from list
            if (!majors.contains(currentText)) {
              return;
            }
            var body= json.encode({
              'firstName': firstNameController.text,
              'lastName': lastNameController.text,
              'gradYear': _currentGradYear,
              'major': currentText,
              "account_id": account_id
            });
            setProfile("${firstNameController.text} ${lastNameController.text}", currentText, _currentGradYear, myToken);
            editProfile("https://aris-backend-staging.herokuapp.com/profile", body, myToken).then((int statusCode) {
              print(statusCode);
            });
            Navigator.pushNamed(context, "/home");
          }
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Padding(padding: EdgeInsets.only(top: 35.0)),
      )
    );
  }
}