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
  late Lobby lobby;   // declare variable but not assign it
  var selectedIndex = 1;
  @override
  void initState() {
    super.initState();      // check if every thing is initialized
    lobby = Lobby(removeCallback: removePlayercallback);  // pass the callback to constructor of lobby class
    lobby.init();   // runs init method to create first container
  } 

  addPlayercallback() {   // callback to rebuild scene and create new input tile
    setState(() {
      lobby.addPlayer();
    });
  }

  removePlayercallback(index) { // callback to rebuild scene and delete input tile at index
    setState(() {
      lobby.removePlayer(index);
    });
  }
  

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
            Flexible(
              child: ListView.builder(
                  shrinkWrap: true,             // makes list not take entire page height             
                  itemCount: lobby.getPlayerListLenght(),
                  itemBuilder: (_, index) => lobby.getPlayer(index),
                ),
            ),
            

            AddPlayerButton(callbackFunction: addPlayercallback),   // gray button at bottom of page
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