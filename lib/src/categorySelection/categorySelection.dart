import 'package:flutter/services.dart';
import 'dart:convert';

Future<Category> loadCategoryFromJson() async {
  final jsonString = await rootBundle.loadString('lib/assets/categories/animals.json');
  final jsonMap = jsonDecode(jsonString);
  return Category.fromJson(jsonMap);
}

class Category {
  final String _name;
  final List<dynamic> _words;
  final List<dynamic> _hints;
  final int _id;
  bool _selected = false;

  Category(
    this._name,
    this._words,
    this._hints,
    this._id,
  );

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(json["name"], json["words"], json["hints"], 0);
  }

//==================================    getters   ==================================
  String getName() {
    return this._name;
  }
  int getId() {
    return this._id;
  }
  bool getSelected() {
    return this._selected;
  }

//==================================    setters  ==================================
  void setSelected(bool selected) {
    _selected = selected;
  }
}