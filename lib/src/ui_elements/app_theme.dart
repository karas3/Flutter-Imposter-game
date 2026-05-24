import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  static const bool _light = true;
  static const bool _dark = false;

  static bool _theme = _dark; 

  ThemeData get theme {
    if(_theme == _light) {
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
    _theme == _light ? _theme = _dark : _theme = _light;
    notifyListeners();
  }

  static IconData get icon {   //return icon for app bar to use
    if(_theme == _light) {
      return Icons.dark_mode; 
    } else {
      return Icons.light_mode;
    }
  }
  static bool get isThemeLight => _theme;
}