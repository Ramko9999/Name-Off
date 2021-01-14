import "package:flutter/material.dart";
import '../../models/User.dart';
import '../../services/User.dart';
import '../../services/Storage.dart';
import '../../util/Config.dart';
import '../../util/RelativeDimension.dart';


class SplashScreen extends StatefulWidget{

  State<SplashScreen> createState(){
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {

  void initState(){
    super.initState();
    Storage.getStorage().then((final storage) async {
      if(storage.isEmpty()){
        Navigator.of(context).pushNamed("/login");
      }
      else{
        User user = await UserApi.getUser(storage.getId());
        Navigator.of(context).pushNamed("/home", arguments: user);
      }
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.bgColor,
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: RelativeDimension.getHeight(context, 0.1)),
              child: Image.asset(
                'assets/logo.png',
                width: RelativeDimension.getWidth(context, 1),
              ),
            ),
            Container(
                width: RelativeDimension.getWidth(context, 0.9),
                padding: EdgeInsets.only(
                    top: RelativeDimension.getHeight(context, 0.001)),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("Loading ...",
                      style: TextStyle(
                          color: Colors.white,
                          backgroundColor: Config.secondaryColor,
                          fontSize: 36,
                          fontFamily: Config.fontFamily,
                          fontWeight: FontWeight.bold)),
                )),
          ],
        )),
      ),
    );
  }
}
