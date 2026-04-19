import 'package:flutter/material.dart';
import 'package:imposter_party_game/src/ui_elements/dialogs.dart';

import 'lobby_object.dart';

class LobbyPlayerInputTileList extends StatefulWidget {
  final List<TextEditingController> controllers;
  final Function addPlayer;
  final Function removePlayer;

  const LobbyPlayerInputTileList({super.key,
    required this.controllers,
    required this.addPlayer,
    required this.removePlayer,
  });

  @override
  State<LobbyPlayerInputTileList> createState() => _LobbyPlayerInputTileListState();
}

class _LobbyPlayerInputTileListState extends State<LobbyPlayerInputTileList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(      
        shrinkWrap: true,       
        itemCount: Lobby.numberOfPlayers + 1,
        itemBuilder: (_, index) {
          if(index < Lobby.numberOfPlayers) {   // player Input Tile
            final player = Lobby.playerList[index];  //get Player object from list of Player objects
            return Dismissible(
              key: ValueKey(widget.controllers[index]),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) => setState(() => widget.removePlayer(index)),
              child: Stack(
                children: [
                  LobbyPlayerInputTile(
                    controller: widget.controllers[index], 
                    colorGetter: () => player.color,   
                    colorSetter: (color) => player.color = color,
                    id: index,                          //id
                  ),
                ],
              ),
            );
          } 
          else {  // Gray button at bottom
            return Center(  // Fixes button infinite width
              child: AddPlayerButton (
                addPlayercallback: () {   // callback to rebuild scene and create new input tile
                  setState(() {
                    widget.addPlayer();
                  });
                }
              ),
            );
          }
        },
      ),
    );
  }
}


class LobbyPlayerInputTile extends StatefulWidget {
  final TextEditingController controller;
  final ValueGetter colorGetter;
  final ValueSetter colorSetter;
  final int id;

  const LobbyPlayerInputTile({super.key, 
    required this.controller,     
    required this.colorGetter,
    required this.colorSetter,
    required this.id,  // to remove object later
  });

  @override
  State<LobbyPlayerInputTile> createState() => LobbyPlayerInputTileState();
}

class LobbyPlayerInputTileState extends State<LobbyPlayerInputTile> {
  Future<Color?> dialogBuilder(BuildContext context) {
    return showDialog<Color>(
      context: context,
      builder: (BuildContext context) {
        return ChangeColorDialog(color: widget.colorGetter());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(      // centers elements
      child: Stack(
//==================================    Box and it's shadow    ================================== 
        children: [ 
          Container(
            margin: EdgeInsets.only(bottom: 20),
            height: 100,
            width: 350,
            decoration: BoxDecoration(                                // style of entire rectangle
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              boxShadow: [
                BoxShadow(  
                  color: Theme.of(context).colorScheme.shadow,
                  offset: Offset(4, 4),
                  blurRadius: 5,
                  spreadRadius: 0,
                )
              ],
            ),
            child: Row(
              children: [
//==================================    Small Color Stripe   ================================== 
                Container(                     
                  margin: EdgeInsets.only(left: 20.0),
                  child: FilledButton(
                    style: ButtonStyle(
                      fixedSize: WidgetStatePropertyAll(Size(40, 100)),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                      backgroundColor: WidgetStatePropertyAll(widget.colorGetter()),
                    ),
                    onPressed: () async {
                      widget.colorSetter(await dialogBuilder(context));
                      setState(() {});
                    },
                    child: null,
                  ),
                ),
//==================================    Container for input field   ==================================
                Container(                        
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 5),
                  width: 210,
                  height: 100,
                  child: TextFormField(                   //input field
                    controller: widget.controller,
                    decoration: InputDecoration(
                      hintText: "Input player ${widget.id + 1}",
                      border: UnderlineInputBorder(),
                    ),
                    style: TextStyle(
                      fontSize: 24
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



//==================================    Add player button (grey transparent one)   ==================================
class AddPlayerButton extends StatelessWidget {
  final Function addPlayercallback;
  
  const AddPlayerButton({super.key, 
    required this.addPlayercallback,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        addPlayercallback();
      },
      style: ButtonStyle(
        fixedSize: WidgetStatePropertyAll(const Size(350, 100)),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
        side: WidgetStatePropertyAll(BorderSide(                                                                // set border width and color
          width: 3.5,
          color: Theme.of(context).colorScheme.outlineVariant,
        )),
      ),
      child: Icon(
        Icons.add,
        color: Theme.of(context).colorScheme.outlineVariant,
        size: 75,
      ),
    );
  }
}