import 'dart:math' show Random;
import 'package:flutter/material.dart' show TextEditingController, Color;

class Player {
  final TextEditingController _nameController = TextEditingController();
  final Color _color = Color.fromARGB(255, Random().nextInt(255) + 1, Random().nextInt(255) + 1, Random().nextInt(255) + 1);  //generate random color

  TextEditingController get controller => _nameController;
  Color get color => _color;
}

class Lobby{ 
  static final List<Player> _playerList = [Player(), Player(), Player()];
  static int _imposterCount = 1;

  static void addPlayer() {                //adds empty player input tile
    _playerList.add(Player());
  }

  static void removePlayer(int index) {    //remove player input tile at index
    _playerList[index].controller.dispose();
    _playerList.removeAt(index);
  }

  // used to display list
  static Player getPlayer(int index) => _playerList[index];
  static int get playerListLenght => _playerList.length;

  static int get imposterCount => _imposterCount;
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