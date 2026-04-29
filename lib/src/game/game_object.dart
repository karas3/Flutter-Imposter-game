import 'dart:math';
import 'package:flutter/material.dart';
import 'package:imposter_party_game/src/lobby/lobby_object.dart';

class GameState extends ChangeNotifier{
  final List<String> _playerList = Lobby.playerNames;
  final List<HSLColor> _playersColors = Lobby.playersColors;
  final List<int> _impostersId = [];
  int _currentIndex = 0;

  late final String _word;
  late final String _hint;

  GameState({required List<String> wordsList, required List<String> hintsList}) {
    // players randomization
    List<int> numberPoll = List.generate(playerCount, (int index) => index);
    for(int i = 0; i < Lobby.imposterCount; i++) {
      int imposterIndex = Random().nextInt(numberPoll.length);
      _impostersId.add(numberPoll[imposterIndex]);
      numberPoll.removeAt(imposterIndex);
    }

    // word randomization
    int index = Random().nextInt(wordsList.length);
    _word = wordsList[index];
    _hint = hintsList[index];
  }

  void incrementCurrentIndex() {
    _currentIndex++;
    notifyListeners();
  }
  
  int get currentIndex => _currentIndex;
  List<String> get playerList => _playerList;
  int get playerCount => _playerList.length;
  String get word => _word;
  String get hint => _hint;
  HSLColor get currentPlayerColor => _playersColors[currentIndex];
  HSLColor get oldPlayerColor => _currentIndex > 0 ? _playersColors[currentIndex - 1] : _playersColors[currentIndex];

  bool get isImposter {
    for(int i = 0; i < _impostersId.length; i++) {
      if(_currentIndex == _impostersId[i]) return true;
    }
    return false;
  }

// =========================== DEBUG ===========================
  // String whoIsPlayer(int index) {
  //   for(int i = 0; i < _impostersId.length; i++) {
  //     if(index == _impostersId[i]) return "Imposter";
  //   }
  //   return "Civilian";
  // }
}