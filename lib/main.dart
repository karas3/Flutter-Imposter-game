import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/lobby/lobby_page.dart';
import 'src/home_page.dart';
import 'src/info_page.dart';

import 'src/ui_elements/app_theme.dart';
import 'src/ui_elements/custom_bottom_navigation_bar.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppTheme(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;  // home
  final PageController _pageController = PageController();    // Controls pages next to each other so it is possible to swipe between them

  @override
  Widget build(BuildContext cosntext) {

    return MaterialApp( 
      debugShowCheckedModeBanner: false,
      theme: context.watch<AppTheme>().getTheme(),
      
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
            Lobbypage(),
            InfoPage(),
          ],
        ),
      
        bottomNavigationBar: CustomBottomNavigationBar(pageController: _pageController, selectedIndex: _selectedIndex)
      ),
    );
  }
}