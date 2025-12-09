import 'package:flutter/material.dart';

import 'src/lobby/lobbyPage.dart';
import 'src/homePage.dart';
import 'src/infoPage.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;  // home

  List<Widget> _screens = [
    HomePage(),
    Lobbypage(),
    InfoPage(),
  ];
  

  @override
  Widget build(BuildContext cosntext) {
    return MaterialApp( 
      theme: ThemeData(useMaterial3: false, scaffoldBackgroundColor: const Color.fromARGB(255, 228, 228, 228)),   //page background color
      debugShowCheckedModeBanner: false,

      
      home: Scaffold(
//==================================    Top title bar   ==================================  
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 50, 125, 175),   //top bar color
          centerTitle: true,
          title: const Text(
            "Imposter Game",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
          ),   // text on top bar
          elevation: 20,  //Set shadow on top bar
        ),


        body: _screens[_selectedIndex],


        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
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