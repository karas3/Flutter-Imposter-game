import 'package:flutter/material.dart';

import 'lobbyUI.dart';
import 'lobby.dart';
import '../UIElements/customAppBar.dart';
import '../categorySelection/categorySelectionPage.dart';

class Lobbypage extends StatefulWidget {
  final Lobby lobby;  //needs to be defined in main so data doesn't get wiped out while switching between pages in bottom navigation bar

  const Lobbypage({
    required this.lobby,
  });

  @override
  State<Lobbypage> createState() => _LobbypageState();
}

class _LobbypageState extends State<Lobbypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Create Lobby"),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
          //==================================    List of players   ================================== 
            Flexible(   //Fixes overflow of list
              child: ListView.builder(             
                itemCount: widget.lobby.getPlayerListLenght() + 1,
                itemBuilder: (_, index) {
        
                  if(index < widget.lobby.getPlayerListLenght()) {   // player Input Tile
                    final player = widget.lobby.getPlayer(index);  //get Player object from list of Player objects
                    return LobbyPlayerInputTile(
                      controller: player.getController(), 
                      color:  player.getColor(),   
                      id: index,                          //id
                      removeCallbackFunction: () {  //callback to rebuild the scene and delete one of input tiles
                        setState(() {
                          widget.lobby.removePlayer(index);
                        });
                      },
                    );
                  } 
                  else {  // Gray button at bottom
                    return Center(  // Fixes button infinite width
                      child: AddPlayerButton (
                        addPlayercallback: () {   // callback to rebuild scene and create new input tile
                          setState(() {
                            widget.lobby.addPlayer();
                          });
                        }
                      ),
                    );
                  }
                },
              ),
            ),
            
            StartButton(nextPage: CategorySelectionPage(),),
          ],
        ),
      ),
    );
  }
}