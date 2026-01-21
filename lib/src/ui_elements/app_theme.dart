import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  static bool _lightTheme = true; 

  ThemeData getTheme() {
    if(_lightTheme) {
      return ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
          seedColor: Color.fromARGB(255, 66, 140, 192),
        )
      );
    }
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
        seedColor: Color.fromARGB(255, 66, 140, 192),
      )
    );
  }

  void switchTheme() {
    _lightTheme ? _lightTheme = false : _lightTheme = true;
    notifyListeners();
  }
}