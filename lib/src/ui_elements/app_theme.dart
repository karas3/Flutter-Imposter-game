import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  static bool _lightTheme = false; 
  static final double _fontSize = 28;

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

  static IconData getIcon() {   //return icon for app bar to use
    if(_lightTheme) {
      return Icons.dark_mode;
    }
    return Icons.light_mode;
  }
  static bool get isLightTheme => _lightTheme;
  static double get fontSize => _fontSize;
}