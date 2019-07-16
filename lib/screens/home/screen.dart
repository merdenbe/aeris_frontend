import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> printToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header', style: TextStyle(color: Colors.white)),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.school),
              title: Text(
                'Request a Course',
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
                print("Pressed: Send Feedback");
              },
            ),
            ListTile(
              leading: Icon(Icons.question_answer),
              title: Text(
                'FAQ',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                print("Pressed: FAQ");
              },
            ),
          ],
        )
      ),
      appBar: AppBar(
        title: Text(""),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            printToken().then((String token) {
              print(token);
            });
          },
          child: Text('Print Token'),
        )
      )
    );
  }
}