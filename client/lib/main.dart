import 'package:flutter/material.dart';
import 'package:name_off/screens/splash/SplashScreen.dart';
import './screens/auth/LoginScreen.dart';
import  './screens/home/HomeScreen.dart';
import './util/Config.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Config.bgColor,
        buttonColor: Config.secondaryColor,
        fontFamily: Config.fontFamily,
        
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),
        "/login": (context) => LoginScreen(),
        "/home": (context) => HomeScreen(),
      }
    );
  }
}