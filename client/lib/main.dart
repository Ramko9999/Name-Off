import 'package:flutter/material.dart';
import 'package:name_off/models/Lobby.dart';
import 'package:name_off/routes/RouteGenerator.dart';
import 'package:name_off/screens/splash/SplashScreen.dart';
import './screens/auth/LoginScreen.dart';
import  './screens/home/HomeScreen.dart';
import './util/Config.dart';
import './screens/lobby/LobbyScreen.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<Lobby>(Lobby());
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
      onGenerateRoute: (settings) => RouteGenerator.onGenerate(settings),
    );
  }
}