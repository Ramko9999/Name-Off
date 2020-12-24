import "package:flutter/material.dart";
import 'package:name_off/util/Config.dart';
import 'package:name_off/util/RelativeDimension.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController _loginCodeController;

  LoginScreen() {
    this._loginCodeController = new TextEditingController();
  }

  Widget build(BuildContext context) {
    double textPadding = RelativeDimension.getHeight(context, 0.01);

    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Config.bgColor),
      backgroundColor: Config.bgColor,
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: <Widget>[
            Image.asset(
              'assets/logo.png',
              width: 384,
            ),
            Container(
                width: RelativeDimension.getWidth(context, 0.9),
                padding: EdgeInsets.only(
                    top: RelativeDimension.getHeight(context, 0.001)),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Name Off!",
                      style: TextStyle(
                          color: Colors.white,
                          backgroundColor: Config.secondaryColor,
                          fontSize: 36,
                          fontFamily: Config.fontFamily,
                          fontWeight: FontWeight.bold)),
                )),
            Container(
                width: RelativeDimension.getWidth(context, 0.9),
                padding: EdgeInsets.only(
                    top: RelativeDimension.getHeight(context, 0.02)),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('Name',
                          style: TextStyle(
                              color: Colors.white,
                              backgroundColor: Config.secondaryColor,
                              fontSize: 24,
                              fontFamily: Config.fontFamily,
                              fontWeight: FontWeight.bold)),
                    ),
                    TextField(
                      controller: _loginCodeController,
                      decoration: InputDecoration(
                        hintText: "Your name",
                        filled: true,
                        fillColor: Config.textInputColor,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        )),
      ),
    );
  }
}
