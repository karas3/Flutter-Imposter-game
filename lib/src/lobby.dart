import 'lobbyUI.dart';

class Lobby{
  final Function(int) removeCallback;   
  List<LobbyPlayerInputTile> _playerList = [];  
  Lobby({required this.removeCallback});  //lobby constructor
  

  void init() {
   _playerList = [new LobbyPlayerInputTile(index: 0, removeCallbackFunction: removeCallback)];  // add first input tile element
  }

  void addPlayer() {
    var index = _playerList.length;   // get index at which container is storred in array. Used for deleting input tile later
    _playerList.add(new LobbyPlayerInputTile(index: index, removeCallbackFunction: removeCallback));
  }

  void removePlayer(index) {    //remove player input tile at index
    _playerList.removeAt(index);
  }

  getPlayer(index) {     // used to display list
    return _playerList[index];
  }
  int getPlayerListLenght() {   // used to display list
    return _playerList.length;
  }
}