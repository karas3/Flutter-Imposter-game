import 'dart:math' show Random;
import 'package:flutter/material.dart';

class Player {
  String name = "";
  Color color = Color.fromARGB(255, Random().nextInt(255) + 1, Random().nextInt(255) + 1, Random().nextInt(255) + 1);
}

class Lobby{ 
  static final List<Player> _playerList = [Player(), Player(), Player()];
  static int _imposterCount = 1;

  // used to display list
  static List<Player> get playerList => _playerList;
  static int get numberOfPlayers => _playerList.length;
  static int get imposterCount => _imposterCount;
  static int get maxImposterCount => _playerList.length - 2;
  static int get minImposterCount => 1;

  static set playerNames(List<String> names) {
    for(int i = 0; i < _playerList.length; i++) {
      _playerList[i].name = names[i];
    }
  }

  static List<String> get playerNames {
    List<String> names = [];
    for(int i = 0; i < _playerList.length; i++) {
      if(_playerList[i].name.isEmpty) {
        names.add("Player ${i + 1}");
      } else {
        names.add(_playerList[i].name);
      }
    }

    return names;
  }

  static void addPlayer() {                //adds empty player input tile
    _playerList.add(Player());
  }

  static void removePlayer(int index) {    //remove player input tile at index
    _playerList.removeAt(index);
    if (_imposterCount >= maxImposterCount) decreaseImposterCount();
  }

  static void increaseImposterCount() {
    if(_imposterCount < maxImposterCount) _imposterCount++;
  }
  static void decreaseImposterCount() {
    if(_imposterCount > minImposterCount) _imposterCount--;
  }
}