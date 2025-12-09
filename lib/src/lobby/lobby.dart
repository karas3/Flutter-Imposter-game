import 'dart:math' show Random;
import 'package:flutter/material.dart' show TextEditingController, Color;

class Player {
  final TextEditingController _nameController = TextEditingController();    // Makes input persistent for shifting
  final Color _color = Color.fromARGB(255, Random().nextInt(255) + 1, Random().nextInt(255) + 1, Random().nextInt(255) + 1);

  getController() {
    return _nameController;
  }

  getColor() {
    return _color;
  }
}

class Lobby{ 
  List<Player> _playerList = [new Player()];  

  void addPlayer() {                //adds empty player input tile
    _playerList.add(new Player());
  }

  void removePlayer(int index) {    //remove player input tile at index
    _playerList.removeAt(index);
  }



  getPlayer(int index) {            // used to display list
    return _playerList[index];
  }

  int getPlayerListLenght() {   // used to display list
    return _playerList.length;
  }
}