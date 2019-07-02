import 'package:flutter/material.dart';
import 'login_screen_2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Aris'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
	        child: LoginScreen2(
            backgroundColor1: Color(0xFF95B1BD),
            backgroundColor2: Color(0xFFF7F8FC),
            highlightColor: Color(0xFF390D58),
            foregroundColor: Colors.black,
            logo: new AssetImage("assets/images/owl_logo_transparent.png"),
          ),
      )
    );
  }
}
