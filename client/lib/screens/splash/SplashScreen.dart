import "package:flutter/material.dart";
import '../../util/Config.dart';
import '../../util/RelativeDimension.dart';

class SplashScreen extends StatelessWidget {
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
