import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';


class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen>{

  void initState() {
    super.initState();
    determineNav();
  }

  determineNav() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic isRegistered = prefs.getBool('isRegistered');

    await new Future.delayed(const Duration(seconds: 3));
    if (isRegistered == null) {
      Navigator.pushNamed(context, '/register');
    } else {
      Navigator.pushNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/owl_logo_transparent.png'),
                    fit: BoxFit.fill
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Text("PLATO", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xff390D58))),
            ]
          )
        ),
      )
    );
  }
}