// import 'package:flutter/material.dart';

import 'lobbyUI.dart';

// class Player {
//   String _name = "";
//   var _color = Color.fromARGB(0, 0, 0, 0);
//   var _role = "";
// }

class Lobby {
  List<LobbyPlayerInputTile> _playerList = [new LobbyPlayerInputTile()];

  addPlayer() {
    _playerList.add(new LobbyPlayerInputTile());
  }

  getPlayer(index) {
    return _playerList[index];
  }
  getPlayerListLenght() {
    return _playerList.length;
  }
}

var lobby = Lobby();