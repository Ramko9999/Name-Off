import "package:flutter/material.dart";
import '../../util/RelativeDimension.dart';
import '../../util/Config.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _joinCodeController = new TextEditingController();

  Widget build(BuildContext context) {
    double textPadding = RelativeDimension.getHeight(context, 0.01);

    return Scaffold(
      body: SingleChildScrollView(
            child: Container(
            width: RelativeDimension.getWidth(context, 1),
            height: RelativeDimension.getHeight(context, 1),
            color: Config.bgColor,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: RelativeDimension.getHeight(context, 0.05), left: RelativeDimension.getWidth(context, 0.075)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                    "Name Off",
                    style: TextStyle(
                      backgroundColor: Config.secondaryColor,
                      color: Colors.white,
                      fontSize: 36
                      ),
                ),
                  )),
                Container(
                    width: RelativeDimension.getWidth(context, 0.85),
                    padding: EdgeInsets.only(
                        top: RelativeDimension.getHeight(context, 0.25)),
                    child: Container(
                      padding: EdgeInsets.only(
                          top: textPadding,
                          bottom: textPadding,
                          left: textPadding,
                          right: textPadding),
                      color: Config.secondaryColor,
                      child: Text(
                          "Play the classic game name off with your friends!",
                          softWrap: true,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          )),
                    )),
                Container(
                  padding: EdgeInsets.only(
                      top: RelativeDimension.getHeight(context, 0.1)),
                  width: RelativeDimension.getWidth(context, 0.85),
                  child: Container(
                      child: Row(
                    children: <Widget>[
                      Container(
                        width: RelativeDimension.getWidth(context, 0.6),
                        height: RelativeDimension.getHeight(context, 0.05),
                        child: TextField(
                          controller: _joinCodeController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Config.textInputColor,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(
                                      color: Config.borderColor, width: 0.0)),
                              hintText: "type code..."),
                        ),
                      ),
                      Container(
                        height: RelativeDimension.getHeight(context, 0.05),
                        child: RaisedButton(
                          key: Key("join-button"),
                          onPressed: () {
                            print("join-button clicked");
                          },
                          color: Config.secondaryColor,
                          textColor: Colors.white,
                          child: Text(
                            "Join",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      )
                    ],
                  )),
                ),
                Container(
                  width: RelativeDimension.getWidth(context, 0.85),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        padding: EdgeInsets.only(
                            top: RelativeDimension.getHeight(context, 0.05)),
                        width: RelativeDimension.getWidth(context, 0.25),
                        child: Container(
                            child: Container(
                          height: RelativeDimension.getHeight(context, 0.05),
                          child: RaisedButton(
                            key: Key("make-button"),
                            onPressed: () {
                              print("make-button clicked");
                            },
                            color: Config.secondaryColor,
                            textColor: Colors.white,
                            child: Text(
                              "Make",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ))),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
