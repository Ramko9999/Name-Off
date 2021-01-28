import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:name_off/main.dart';
import 'package:name_off/models/Lobby.dart';
import 'package:name_off/models/Player.dart';
import '../../util/Config.dart';
import '../../util/RelativeDimension.dart';
import 'TextBlock.dart';

class LobbyScreen extends StatefulWidget {
  State<LobbyScreen> createState() {
    return _LobbyScreenState();
  }
}

class _LobbyScreenState extends State<LobbyScreen> {
  final lobbyService = getIt.get<Lobby>();

  double timeLimit = 2;
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
                      child: Center(child: TextBlock(text: 'Lobby')),
                    ),
                    color: Config.secondaryColor,
                  ),
                )),
            Container(
              width: RelativeDimension.getWidth(context, 0.9),
              color: Config.secondaryColor,
              padding: EdgeInsets.only(
                  top: RelativeDimension.getHeight(context, 0.001)),
              child: StreamBuilder<Object>(
                  stream: lobbyService.players$,
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    return Column(
                      children: getList(snap.data),
                    );
                  }),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: RelativeDimension.getHeight(context, 0.2)),
              child: Column(
                children: [
                  RaisedButton(
                    onPressed: () => {handleReadyUp()},
                    child: SizedBox(
                      width: RelativeDimension.getWidth(context, 0.55),
                      child: Center(child: TextBlock(text: 'Ready Up')),
                    ),
                    color: Config.secondaryColor,
                  ),
                  RaisedButton(
                    onPressed: () => {handleLeave(context)},
                    child: SizedBox(
                      width: RelativeDimension.getWidth(context, 0.55),
                      child: Center(
                        child: TextBlock(text: 'Leave Lobby'),
                      ),
                    ),
                    color: Config.secondaryColor,
                  ),
                  RaisedButton(
                    onPressed: () =>
                        {Navigator.of(context).pushNamed("/settings")},
                    child: SizedBox(
                      width: RelativeDimension.getWidth(context, 0.55),
                      child: Center(
                        child: TextBlock(text: 'Settings'),
                      ),
                    ),
                    color: Config.secondaryColor,
                  ),
                  RaisedButton(
                    onPressed: () => {handleStart(context)},
                    child: SizedBox(
                      width: RelativeDimension.getWidth(context, 0.55),
                      child: Center(
                        child: TextBlock(text: 'Start'),
                      ),
                    ),
                    color: Config.secondaryColor,
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  void handleLeave(BuildContext context) {
    lobbyService.leaveLobby(lobbyService.getLocalPlayer);
    Navigator.of(context).pop('/lobby');
  }

  void handleStart(BuildContext context) {
    Navigator.of(context).pushNamed("/game");
  }

  void handleReadyUp() {
    Player localPlayer = lobbyService.getLocalPlayer;
    lobbyService.readyUp(localPlayer.socketId);
  }

  List<Widget> getList(List<Player> players) {
    return players.map((Player player) {
      return (player.isReady
          ? (ListTile(
              title: TextBlock(text: player.username),
              trailing: Icon(
                Icons.check_box_rounded,
                color: Config.bgColor,
              ),
            ))
          : (ListTile(
              title: TextBlock(text: player.username),
            )));
    }).toList();
  }
}
