import 'dart:math';
import 'package:imposter_party_game/src/lobby/lobby_object.dart';

class GameState {
  final List<String> playerList = Lobby.playerNames;
  final int _imposterId = Random().nextInt(Lobby.playerList.length);
  final List<String> wordsList;
  final List<String> hintsList;

  GameState(this.wordsList, this.hintsList);
  
  int get playerCount => playerList.length;
  int get imposterId => _imposterId;
  int get wordsCount => wordsList.length;
}