import 'package:flutter/material.dart';
import 'package:imposter_party_game/src/ui_elements/custom_app_bar.dart';

import 'lobby_ui.dart';
import 'lobby_object.dart';

class Lobbypage extends StatefulWidget {
  const Lobbypage({super.key});

  @override
  State<Lobbypage> createState() => _LobbypageState();
}

class _LobbypageState extends State<Lobbypage> {
  late final List<TextEditingController> _controllers = [];

  @override
  void initState() {
    for(int i = 0; i < Lobby.numberOfPlayers; i++) {
      _controllers.add(TextEditingController(text: Lobby.playerList[i].name));
    } 
    super.initState();
  }

  @override
  void dispose() {
    final List<String> names = [];
    for(TextEditingController controller in _controllers) {
      names.add(controller.text);
      controller.dispose();
    }
    Lobby.playerNames = names;
    super.dispose();
  }


  void addPlayer() {                //adds empty player input tile
    Lobby.addPlayer();
    _controllers.add(TextEditingController(text: ""));
  }

  void removePlayer(int index) {    //remove player input tile at index
    Lobby.removePlayer(index);
    _controllers[index].dispose();
    _controllers.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Create Lobby"),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
          //==================================    List of players   ================================== 
            LobbyPlayerInputTileList(controllers: _controllers, addPlayer: addPlayer, removePlayer: removePlayer,),
          ],
        ),
      ),
    );
  }
}