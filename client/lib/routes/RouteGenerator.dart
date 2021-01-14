import "package:flutter/material.dart";
import '../screens/splash/SplashScreen.dart';
import "../screens/auth/LoginScreen.dart";
import "../screens/home/HomeScreen.dart";
import "../models/User.dart";


class RouteGenerator{

  static Route<dynamic> onGenerate(RouteSettings settings){
    dynamic args = settings.arguments;
    switch(settings.name){
      case "/login":
          return MaterialPageRoute(builder: (context) => LoginScreen());      
      case "/home":
          User currentUser = args as User;
          return MaterialPageRoute(builder: (context) => HomeScreen(currentUser: currentUser));
      default:
          return MaterialPageRoute(builder: (context) => SplashScreen());
    }
  }
}



