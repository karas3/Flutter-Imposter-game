import 'package:flutter/material.dart';
import 'package:imposter_party_game/src/extensions/color_extension.dart';

class AppTextStyles {
  static TextStyle standard = TextStyle(
    fontSize: 28,
  );

  static TextStyle standardSmall = TextStyle(
    fontSize: 22,
  );

  static TextStyle hint(BuildContext context) => TextStyle(
    fontSize: 12,
    color: Theme.of(context).colorScheme.inverseSurface,
    backgroundColor: Colors.transparent,
  );

// ============================================ CATEGORY SELECTION PAGE ============================================
  static TextStyle gridElement(BuildContext context, bool selected) => TextStyle(
    fontSize: selected ? 22 : 18,
    color: selected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface
  );

// ============================================ CATEGORY EDIT PAGE ============================================
  static TextStyle header = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  static TextStyle tableStandard = TextStyle(
    fontSize: 22,
  );

  static TextStyle tableHeader = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold
  );

  static TextStyle tableHint = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w300,
  );

// ============================================ GAME PAGE ============================================
  static TextStyle gamePageHeaderText(HSLColor backgroundColor) => TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: backgroundColor.lightness < 0.5
    ? Colors.white
    : Colors.black
  );
  static TextStyle gamePageText(HSLColor backgroundColor) => TextStyle(
    fontSize: 28,
    color: backgroundColor.lightness < 0.5
    ? Colors.white
    : Colors.black
  );

  static TextStyle gamePageNextButton(BuildContext context, bool isEnabled) {
    final Color color = Theme.of(context).colorScheme.onPrimary;
    return TextStyle(
      fontSize: 28,
      color: isEnabled
      ? color
      : color.adjust(alpha: 0.3, saturation: 0)
    );
  } 
  
  
// ============================================ UI ELEMENTS ============================================
  static TextStyle appBar(BuildContext context) => TextStyle(
    fontSize: 28, 
    fontWeight: FontWeight.bold, 
    color: Theme.of(context).colorScheme.onPrimary
  );

// ============================================ DIALOGS ============================================
  static TextStyle dialogTitle = TextStyle(
    fontSize: 24,
  );

  static TextStyle dialogDescription = TextStyle(
    fontSize: 16
  );
}