import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:name_off/main.dart';
import 'package:name_off/models/Lobby.dart';
import '../../util/Config.dart';
import '../../util/RelativeDimension.dart';
import '../lobby/TextBlock.dart';

class GameScreen extends StatefulWidget {
  State<GameScreen> createState() {
    return _GameScreenState();
  }
}

class _GameScreenState extends State<GameScreen> {
  final lobbyService = getIt.get<Lobby>();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.bgColor,
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(
                    top: RelativeDimension.getHeight(context, 0.1),
                    bottom: RelativeDimension.getHeight(context, 0.1),
                    left: RelativeDimension.getWidth(context, 0.075)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: SizedBox(
                      width: RelativeDimension.getWidth(context, 0.3),
                      child: Center(child: TextBlock(text: 'Game')),
                    ),
                    color: Config.secondaryColor,
                  ),
                )),
          ],
        )),
      ),
    );
  }
}
