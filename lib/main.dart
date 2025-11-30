import 'package:flutter/material.dart';

import 'src/lobbyUI.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var selectedIndex = 1;
  List<LobbyPlayerInputTile> playerList = [new LobbyPlayerInputTile()];

  addPlayer() {
    playerList.add(new LobbyPlayerInputTile());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      theme: ThemeData(useMaterial3: false, scaffoldBackgroundColor: const Color.fromARGB(255, 228, 228, 228)),   //page backgroundcolor

      
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 50, 125, 175),   //top bar color
          centerTitle: true,
          title: const Text("Imposter Game"),   // text on top bar
          elevation: 20,  //Set shadow on top bar
        ),


        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              addPlayer();
            });
          },
        ),


        body: Column(
          children: [
            LobbyHeader(),

            Expanded(
              child: ListView.builder(   // list of players
                  shrinkWrap: true,
                  itemCount: playerList.length,
                  itemBuilder: (_, index) => playerList[index],
                ),
            ),
            

            AddPlayerButton(),
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


        drawer: Drawer(
          child: Text("Cos"),
        ),
      ),
    );
  }
}