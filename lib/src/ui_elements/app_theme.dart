import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  static bool _lightTheme = false; 

  ThemeData getTheme() {
    if(_lightTheme) {
      return ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: Color.fromARGB(255, 0, 153, 255),
        )
      );
    }
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: Color.fromARGB(255, 0, 153, 255),
      )
    );
  }

  void switchTheme() {
    _lightTheme ? _lightTheme = false : _lightTheme = true;
    notifyListeners();
  }
}