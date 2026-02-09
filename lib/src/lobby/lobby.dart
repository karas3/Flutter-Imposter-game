import 'dart:math' show Random;
import 'package:flutter/material.dart' show TextEditingController, Color;

class Player {
  final TextEditingController _nameController = TextEditingController();    // Makes input persistent for shifting
  final Color _color = Color.fromARGB(255, Random().nextInt(255) + 1, Random().nextInt(255) + 1, Random().nextInt(255) + 1);

  TextEditingController getController() {
    return _nameController;
  }

  Color getColor() {
    return _color;
  }

  void dispose() {
    _nameController.dispose();
  }
}

class Lobby{ 
  static final List<Player> _playerList = [Player(), Player(), Player()];  
  static int _imposterCount = 1;

  static void addPlayer() {                //adds empty player input tile
    _playerList.add(Player());
  }

  static void removePlayer(int index) {    //remove player input tile at index
    _playerList[index].dispose();
    _playerList.removeAt(index);
  }


  static Player getPlayer(int index) {            // used to display list
    return _playerList[index];
  }

  static int getPlayerListLenght() {   // used to display list
    return _playerList.length;
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

  static int getImposterCount() {
    return _imposterCount;
  }
}