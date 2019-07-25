import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen>{

  String name = '';
  String gradYear = '';
  String major = '';

  getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      gradYear = prefs.getString('gradYear');
      major = prefs.getString('major');
    });
  }

  void initState() {
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 30.0)),
                Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/defaultProfilePic.jpg'),
                      fit: BoxFit.fill
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 35.0)),
                Text(
                  ' ${this.name} ',
                  style: TextStyle(fontSize: 36.0, color: Colors.black),
                ),
                Padding(padding: EdgeInsets.only(top: 5.0)),
                Text(
                  'University of Notre Dame',
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
                Padding(padding: EdgeInsets.only(top: 5.0)),
                Text(
                  '${this.major}, ${this.gradYear}',
                  style: TextStyle(fontSize: 18.0, color: Colors.black)
                ),
                Padding(padding: EdgeInsets.only(top: 35.0))
              ]
            )
          ),
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        icon: Icon(Icons.edit),
        label: Text('Edit Profile'),
        onPressed: () {
          Navigator.pushNamed(context, "/edit_profile");
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        child: Padding(padding: EdgeInsets.only(top: 35.0)),
      )
    );
  }
}