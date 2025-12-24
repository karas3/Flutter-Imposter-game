import 'package:flutter/material.dart';

import 'src/lobby/lobby_page.dart';
import 'src/home_page.dart';
import 'src/info_page.dart';

import 'src/lobby/lobby.dart';
import 'src/ui_elements/custom_bottom_navigation_bar.dart';

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
  final PageController _pageController = PageController();    // Controls pages next to each other so it is possible to swipe between them
  var lobby = Lobby();    // needs to be defined in main so data doesn't get wiped out while switching between pages in bottom navigation bar
  

  @override
  Widget build(BuildContext cosntext) {
    return MaterialApp( 
      theme: ThemeData(scaffoldBackgroundColor: const Color.fromARGB(255, 228, 228, 228)),   //page background color
      debugShowCheckedModeBanner: false,

      
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: <Widget>[
            HomePage(),
            Lobbypage(lobby: lobby,),
            InfoPage(),
          ],
        ),
      


        bottomNavigationBar: CustomBottomNavigationBar(pageController: _pageController, selectedIndex: _selectedIndex)
      ),
    );
  }
}