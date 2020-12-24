import "package:flutter/material.dart";
import 'package:name_off/util/RelativeDimension.dart';

class HomeScreen extends StatelessWidget {
  TextEditingController _joinCodeController;
  TextEditingController _makeCodeController;

  HomeScreen() {
    this._joinCodeController = new TextEditingController();
    this._makeCodeController = new TextEditingController();
  }

  Widget build(BuildContext context) {

    double textPadding = RelativeDimension.getHeight(context, 0.01);


    return Scaffold(
      appBar: AppBar(title: Text("Name Off")),
      body: Container(
          width: RelativeDimension.getWidth(context, 1),
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: <Widget>[
              Container(
                width: RelativeDimension.getWidth(context, 0.65),
                padding: EdgeInsets.only(top: RelativeDimension.getHeight(context, 0.2)),
                child: Container(
                  padding: EdgeInsets.only(top: textPadding, bottom: textPadding, left: textPadding, right: textPadding),
                  color: Theme.of(context).primaryColor,
                  child: Text("Play the classic game name off with your friends!",
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    )
                  ),
                )
                ),
              Container(
                width: RelativeDimension.getWidth(context, 0.7),
                child: Container(
                  child: TextField(
                    controller: _joinCodeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0.0
                        )
                        ),
                      hintText: "type code",
                      fillColor: Theme.of(context).accentColor),
                      
                )),
              )
            ],
          )),
    );
  }
}
