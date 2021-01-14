
import "package:flutter/material.dart";
import '../Config.dart';
import '../RelativeDimension.dart';

class LoadingBar extends StatelessWidget {
  
  String _loadingMessage;

  LoadingBar(String message){
    this._loadingMessage = message;
  }

  Widget build(BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: RelativeDimension.getWidth(context, 0.7),
              height: RelativeDimension.getHeight(context, 0.05),
              child: LinearProgressIndicator(
                value: null,
                backgroundColor: Config.bgColor,
                valueColor:
                    AlwaysStoppedAnimation<Color>(Config.secondaryColor),
              )),
          Container(
              width: RelativeDimension.getWidth(context, 0.9),
              padding: EdgeInsets.only(
                  top: RelativeDimension.getHeight(context, 0.01)),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(this._loadingMessage,
                    style: TextStyle(
                        color: Colors.white,
                        backgroundColor: Config.secondaryColor,
                        fontSize: 36,
                        fontFamily: Config.fontFamily,
                        fontWeight: FontWeight.bold)),
              )),
        ],
      );
  }
}
