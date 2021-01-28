import "package:flutter/material.dart";
import 'package:name_off/screens/Settings/SettingsScreen.dart';
import 'package:name_off/screens/game/GameScreen.dart';
import 'package:name_off/screens/lobby/LobbyScreen.dart';
import '../screens/splash/SplashScreen.dart';
import "../screens/auth/LoginScreen.dart";
import "../screens/home/HomeScreen.dart";
import "../screens/game/GameScreen.dart";
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
      case '/lobby':
          User currentUser = args as User;
          return MaterialPageRoute(builder: (context) => LobbyScreen());
      case '/settings':
          return MaterialPageRoute(builder: (context)=> SettingsScreen());
      case '/game':
          return MaterialPageRoute(builder: (context)=> GameScreen());
      default:
          return MaterialPageRoute(builder: (context) => SplashScreen());

    }
  }
}



