import 'package:name_off/models/Player.dart';
import 'package:rxdart/rxdart.dart';
import 'Player.dart';
class Lobby {
  BehaviorSubject _settings = BehaviorSubject.seeded({'time':'15', 'players':'5', 'deck': 'Soccer Players'});
  // ignore: close_sinks
  BehaviorSubject _players = BehaviorSubject.seeded([Player('sponge', '1234', 'abc', 10, 10, true), Player('ramko999', '12345', 'abcd', 10, 10, true)]);

  // ignore: close_sinks
  BehaviorSubject _localPlayer = BehaviorSubject.seeded(Player('Null', '12', 'abc', 10, 10, false)); // Local player


  Stream get localPlayer$ => _localPlayer.stream;
  Player get getLocalPlayer => _localPlayer.value;
  Stream get players$ => _players.stream;
  List get currentPlayers => _players.value;
  Stream get settings$ => _settings.stream;
  Map get currentSettings => _settings.value;

  setLocalPlayer(Player player) {
    _localPlayer.add(player);
  }

  leaveLobby(Player localPlayer) {
    var filterPlayers = currentPlayers.where((element) => element.id!= localPlayer.id).toList();
    _players.add(filterPlayers);
  }

  readyUp(String socketId) {
    for (Player player in currentPlayers) {
      if (socketId == player.socketId) {
          player.isReady = ! player.isReady;
      }
    }
    _players.add(currentPlayers);
  }

  lobbyReady(){
    var filterPlayers = currentPlayers.where((element) => element.isReady).toList();
    return filterPlayers.length == currentPlayers.length;
  }

  joinLobby(Player player){
    currentPlayers.add(player);
    _players.add(currentPlayers);
  }
  
  changeSettings(String key, String val) {
    currentSettings[key] = val;
    _settings.add(currentSettings);
  }
}

