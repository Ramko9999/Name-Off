import 'package:flutter/material.dart';
import 'package:name_off/models/Lobby.dart';
import 'package:name_off/screens/lobby/TextBlock.dart';
import 'package:name_off/util/Config.dart';
import 'package:name_off/util/RelativeDimension.dart';

import '../../main.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final lobbyService = getIt.get<Lobby>();

  double timeLimit = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Config.secondaryColor),
        backgroundColor: Config.bgColor,
        elevation: 0,
      ),
      backgroundColor: Config.bgColor,
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.only(
          top: RelativeDimension.getHeight(context, 0.1),
        ),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: RelativeDimension.getWidth(context, 0.06)),
                    alignment: Alignment.topLeft,
                    child: TextBlock(
                      text: 'Players',
                    ),
                  ),
                  StreamBuilder(
                      stream: lobbyService.settings$,
                      builder: (BuildContext context, AsyncSnapshot snap) {
                        return Slider(
                
                          value: double.parse(snap.data['players']),
                          activeColor: Config.secondaryColor,
                          min: 2,
                          max: 5,
                          divisions: 3,
                          onChanged: (newValue) => {
                            lobbyService.changeSettings(
                                'players', newValue.toString())
                          },
                          label: snap.data['players'],
                        );
                      }),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: RelativeDimension.getWidth(context, 0.06)),
                    alignment: Alignment.topLeft,
                    child: TextBlock(
                      text: 'Time',
                    ),
                  ),
                  StreamBuilder(
                      stream: lobbyService.settings$,
                      builder: (BuildContext context, AsyncSnapshot snap) {
                        return Slider(
                          activeColor: Config.secondaryColor,
                          value: double.parse(snap.data['time']),
                          min: 3,
                          max: 15,
                          divisions: 12,
                          onChanged: (newValue) => {
                            lobbyService.changeSettings(
                                'time', newValue.toString())
                          },
                          label: snap.data['time'],
                        );
                      }),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: RelativeDimension.getWidth(context, 0.06)),
                    alignment: Alignment.topLeft,
                    child: TextBlock(
                      text: 'Deck',
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: RelativeDimension.getWidth(context, 0.06),
                        top: RelativeDimension.getHeight(context, 0.02),
                        bottom: RelativeDimension.getHeight(context, 0.02)),
                    alignment: Alignment.topLeft,
                    child: StreamBuilder(
                        stream: lobbyService.settings$,
                        builder: (BuildContext context, AsyncSnapshot snap) {
                          return DropdownButton<String>(
                            value: snap.data['deck'],
                            icon: Icon(
                              Icons.arrow_downward,
                              color: Config.secondaryColor,
                            ),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(
                                color: Config.secondaryColor,
                                fontFamily: Config.fontFamily,
                                fontSize: 18),
                            underline: Container(
                              height: 2,
                              color: Config.secondaryColor,
                            ),
                            onChanged: (String newValue) {
                              lobbyService.changeSettings('deck', newValue);
                            },
                            items: <String>[
                              'Soccer Players',
                              'Soccer Teams',
                              'Basketball Players',
                              'Basketball Teams'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          );
                        }),
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: () => {Navigator.of(context).pushNamed("/lobby")},
              child: SizedBox(
                width: RelativeDimension.getWidth(context, 0.55),
                child: Center(
                  child: TextBlock(text: 'Lobby'),
                ),
              ),
              color: Config.secondaryColor,
            ),
          ],
        ),
      )),
    );
  }
}
