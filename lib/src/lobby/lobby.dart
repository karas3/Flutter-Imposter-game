import 'dart:math' show Random;
import 'package:flutter/material.dart';

class Player {
  String name = "";
  final Color color = Color.fromARGB(255, Random().nextInt(255) + 1, Random().nextInt(255) + 1, Random().nextInt(255) + 1);
}

class Lobby{ 
  static final List<Player> _playerList = [Player(), Player(), Player()];
  static int _imposterCount = 1;

  static void addPlayer() {                //adds empty player input tile
    _playerList.add(Player());
  }

  static void removePlayer(int index) {    //remove player input tile at index
    _playerList.removeAt(index);
  }

  // used to display list
  static List<Player> get playerList => _playerList;
  static int get playerListLenght => _playerList.length;
  static int get imposterCount => _imposterCount;

  static set playerNames(List<String> names) {
    for(int i = 0; i < _playerList.length; i++) {
      _playerList[i].name = names[i];
    }
  }

  static void increaseImposterCount() {
    if(_imposterCount < _playerList.length - 2) { //atleast 2 normal players needed
      _imposterCount++;
    }
  }
  static void decreaseImposterCount() {
    if(_imposterCount > 1) {
      _imposterCount--;
    }
  }
}