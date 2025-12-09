import 'package:flutter/material.dart';

import 'src/lobbyUI.dart';
import 'src/lobby.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var lobby = Lobby();
  var selectedIndex = 1;
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      theme: ThemeData(useMaterial3: false, scaffoldBackgroundColor: const Color.fromARGB(255, 228, 228, 228)),   //page background color

      
      home: Scaffold(
//==================================    Top title bar   ==================================  
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 50, 125, 175),   //top bar color
          centerTitle: true,
          title: const Text("Imposter Game"),   // text on top bar
          elevation: 20,  //Set shadow on top bar
        ),


        body: Column(
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
        ),


        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow),
              label: "play",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: "informations"
            ),
          ]
        ),
      ),
    );
  }
}