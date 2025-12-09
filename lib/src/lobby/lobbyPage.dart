import 'package:flutter/material.dart';
import 'lobbyUI.dart';
import 'lobby.dart';

class Lobbypage extends StatefulWidget {
  @override
  State<Lobbypage> createState() => _LobbypageState();
}

class _LobbypageState extends State<Lobbypage> {
  var lobby = Lobby();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LobbyHeader(),

  //==================================    List of players   ================================== 
        Flexible(   //Fixes overflow of list
          child: ListView.builder(             
            itemCount: lobby.getPlayerListLenght() + 1,
            itemBuilder: (_, index) {

              if(index < lobby.getPlayerListLenght()) {   // player Input Tile
                final player = lobby.getPlayer(index);  //get Player object from list of Player objects
                return LobbyPlayerInputTile(
                  controller: player.getController(), 
                  color:  player.getColor(),   
                  id: index,                          //id for later removal
                  removeCallbackFunction: (int id) {  //callback to rebuild the scene and delete one of input tiles
                    setState(() {
                      lobby.removePlayer(id);
                    });
                  },
                );
              } 

              else {  // Gray button at bottom
                return Center(  // Fixes button infinite width
                  child: AddPlayerButton (
                    addPlayercallback: () {   // callback to rebuild scene and create new input tile
                      setState(() {
                        lobby.addPlayer();
                      });
                    }
                  ),
                );
              }
            },
          ),
        ),
        
        StartButton(),
      ],
    );
  }
}