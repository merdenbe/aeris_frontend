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