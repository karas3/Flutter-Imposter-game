import 'package:flutter/material.dart';
import 'app_theme.dart';

class AppTextStyles {
  static TextStyle standard = TextStyle(
    fontSize: AppTheme.fontSize, // 28px
  );

  static TextStyle standardSmall = TextStyle(
    fontSize: AppTheme.fontSize * 0.8, // 22px
  );

  static TextStyle hint(BuildContext context) => TextStyle(
    fontSize: AppTheme.fontSize * 0.43, // 12px
    color: Theme.of(context).colorScheme.inverseSurface,
    backgroundColor: Colors.transparent,
  );

  static TextStyle header = TextStyle(
    fontSize: AppTheme.fontSize, // 28px
    fontWeight: FontWeight.bold,
  );

  static TextStyle tableStandard = TextStyle(
    fontSize: AppTheme.fontSize * 0.8, // 22px
  );

  static TextStyle tableHeader = TextStyle(
    fontSize: AppTheme.fontSize * 0.8, // 22px
    fontWeight: FontWeight.bold
  );

  static TextStyle tableHint = TextStyle(
    fontSize: AppTheme.fontSize * 0.8, // 22px
    fontWeight: FontWeight.w300,
  );

  static TextStyle appBar(BuildContext context) => TextStyle(
    fontSize: AppTheme.fontSize, 
    fontWeight: FontWeight.bold, 
    color: Theme.of(context).colorScheme.onPrimary
  );

  static TextStyle gridElement(bool selected) => TextStyle(
    fontSize: selected ? AppTheme.fontSize * 0.8 : AppTheme.fontSize * 0.65 // 22px && 18px
  );
  
  static TextStyle gamePageText(HSLColor backgroundColor) => TextStyle(
    fontSize: AppTheme.fontSize * 1.3, // 28px
    fontWeight: FontWeight.bold,
    color: backgroundColor.lightness < 0.5
    ? Colors.white
    : Colors.black
  );

  static TextStyle dialogTitle = TextStyle(
    fontSize: AppTheme.fontSize * 0.85, // ~ 24px
  );

  static TextStyle dialogDescription = TextStyle(
    fontSize: AppTheme.fontSize * 0.57, // ~ 16px
  );
}