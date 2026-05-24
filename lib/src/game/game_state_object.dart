import 'dart:math';
import 'package:flutter/material.dart';
import 'package:imposter_party_game/src/lobby/lobby_object.dart';

class GameState extends ChangeNotifier{
  final List<String> _playerNames = Lobby.playerNames;
  final List<HSLColor> _playersColors = Lobby.playersColors;
  final List<int> _impostersId = [];
  int _currentIndex = 0;
  late final String _word;
  late final String _hint;

  bool didAppThemeChange = false; //check if app theme changed to switch colors in correct order

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
    didAppThemeChange = false;
    _currentIndex++;
    notifyListeners();
  }
  
  int get currentIndex => _currentIndex;
  int get playerCount => _playerNames.length;
  String get word => _word;
  String get hint => _hint;
  String get currentPlayerName => _playerNames[_currentIndex];
  HSLColor get currentPlayerColor => _playersColors[_currentIndex];

  bool get isPlayerLast => _currentIndex + 1 < playerCount; //used for next button
  bool get isImposter {
    for(int i = 0; i < _impostersId.length; i++) {
      if(_currentIndex == _impostersId[i]) return true;
    }
    return false;
  }
}

class NextPlayerButtonState extends ChangeNotifier {
  bool _isEnabled = false; // used to prevent player switching too fast

  void enable() {
    _isEnabled = true;
    notifyListeners();
  }
  void disable() {
    _isEnabled = false;
  }
  bool get isEnabled => _isEnabled;
}