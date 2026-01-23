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
  static final List<Player> _playerList = [Player()];  

  static void addPlayer() {                //adds empty player input tile
    _playerList.add(Player());
    print(_playerList.length);
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
}