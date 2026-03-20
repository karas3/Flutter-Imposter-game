import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/home_page.dart';
import 'src/info_page.dart';
import 'src/play/play_page.dart';

import 'src/ui_elements/app_theme.dart';
import 'src/ui_elements/custom_bottom_navigation_bar.dart';

import 'src/category_managment/load_category.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppTheme(),
      child: const MyApp(),
    ),
  );

  ensureDefaultCateogryExists();  // checks if assets are present inside app document directory so later they can be edited if not adds them
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
            PlayPage(),
            InfoPage(),
          ],
        ),
      
        bottomNavigationBar: CustomBottomNavigationBar(pageController: _pageController, selectedIndex: _selectedIndex)
      ),
    );
  }
}