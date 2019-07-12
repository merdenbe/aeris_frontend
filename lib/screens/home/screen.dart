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
              title: Text('Login'),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            )
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