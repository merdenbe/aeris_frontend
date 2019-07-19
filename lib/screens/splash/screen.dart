import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen>{
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