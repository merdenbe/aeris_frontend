import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:nice_button/nice_button.dart';

class HomeScreen extends StatefulWidget{
  @override
  HomeScreenState createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen>{

  String stateText;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
  }

  String chosenCourse = "Fundamentals of Computing";

  List<String> PickerData = [
    "Fundamentals of Computing"
  ];

  showPicker(BuildContext context) {
    Picker picker = Picker(
      confirmTextStyle: TextStyle(color: Colors.blue, fontSize: 18.0),
      cancelTextStyle: TextStyle(color: Colors.blue, fontSize: 18.0),
      adapter: PickerDataAdapter<String>(pickerdata: PickerData),
      changeToFirst: true,
      textAlign: TextAlign.left,
      columnPadding: const EdgeInsets.all(8.0),
      onConfirm: (Picker picker, List value) {
        print(value.toString());
        print(picker.getSelectedValues());
        setState(() {
          chosenCourse = picker.getSelectedValues()[0];
        });
      }
    );
    picker.show(_scaffoldKey.currentState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Michael Erdenberger"),
              accountEmail: Text("merdenbe@nd.edu"),
              currentAccountPicture: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/profile");
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/defaultProfilePic.jpg'
                  )
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.card_giftcard),
              title: Text(
                'Redeem Coupons',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/coupons');
              },
            ),
            ListTile(
              leading: Icon(Icons.school),
              title: Text(
                'Request Courses',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/course_request');
              },
            ),
            ListTile(
              leading: Icon(Icons.rate_review),
              title: Text(
                'Send Feedback',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/feedback');
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text(
                'FAQ',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/faq');
              },
            ),
            Divider(),
            Padding(padding: EdgeInsets.only(top: 375.0)),
            ListTile(
              leading: Icon(Icons.keyboard_return),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        )
      ),
      appBar: AppBar(
        title: Text(""),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Find a Tutor',
                style: TextStyle(color: Colors.blue, fontSize: 25.0)
              ),
              Padding(padding: EdgeInsets.only(top: 30.0)),
              Text(
                'Select Course',
                style: TextStyle(color: Colors.blue, fontSize: 15.0)
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              RaisedButton(
                child: Text(chosenCourse),
                onPressed: () {
                  showPicker(context);
                },
              ),
              Padding(padding: EdgeInsets.only(top: 30.0)),
              Text(
                'Select Topic',
                style: TextStyle(color: Colors.blue, fontSize: 15.0)
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              RaisedButton(
                child: Text(chosenCourse),
                onPressed: () {
                  showPicker(context);
                },
              ),
              Padding(padding: EdgeInsets.only(top: 50.0)),
              NiceButton(
                width: 400,
                elevation: 8,
                radius: 52,
                padding: const EdgeInsets.all(10),
                text: "Find Tutor",
                gradientColors: [Color(0xff5b86e5), Color(0xff36d1dc)],
                onPressed: () {
                  print("pressed");
                }
              ),
            ],
          ),
        ),
      )
    );
  }
}