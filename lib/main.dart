import 'package:flutter/material.dart';
import 'package:aris_frontend/blocprovs/example-bloc-prov.dart';
import 'package:aris_frontend/blocs/example-bloc.dart';

import 'package:aris_frontend/theme/style.dart';

import 'package:aris_frontend/screens/register/screen.dart';
import 'package:aris_frontend/screens/home/screen.dart';
import 'package:aris_frontend/screens/login/screen.dart';


void main() {
  runApp(myApp());
}


class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExampleProvider(
      bloc: ExampleBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aris',
        theme: appTheme(),
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          "/register": (BuildContext context) => RegisterScreen(),
          "/home": (BuildContext context) => HomeScreen(),
          "/": (BuildContext context) => LoginScreen(),
        },
      ),
    );
  }
}
