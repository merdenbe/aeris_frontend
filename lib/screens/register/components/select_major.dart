import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class SelectMajorDropdown extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SelectMajorDropdownState();
  }
}

class _SelectMajorDropdownState extends State<SelectMajorDropdown> {
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

  @override
  Widget build(BuildContext context) {
    return SimpleAutoCompleteTextField(
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
      }),
    );
  }
}