import 'package:flutter/material.dart';

class StandardTextField extends StatefulWidget {
  final String title;

  StandardTextField({Key key, @required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StandardTextFieldState(title);
  }
}

class _StandardTextFieldState extends State<StandardTextField> {
  String title;

  _StandardTextFieldState(this.title);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Enter ${title}',
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter some text';
        }
        return null;
      },
    );
  }
}