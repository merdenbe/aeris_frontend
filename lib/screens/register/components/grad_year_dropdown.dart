import 'package:flutter/material.dart';

class GradYearDropDown extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GradYearDropDownState();
  }
}

class _GradYearDropDownState extends State<GradYearDropDown> {

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
    return Align(
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
    );
  }
}