import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PasswordTextFieldState();
  }
}

class _PasswordTextFieldState extends State<PasswordTextField> {

  bool _isHidden = true;
  void _toggleVisibility(){
    setState(() {
      _isHidden = !_isHidden;
    });
  }


  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
    );
  }
}