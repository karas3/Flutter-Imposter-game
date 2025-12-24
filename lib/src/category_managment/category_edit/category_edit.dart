import 'package:flutter/material.dart' show TextEditingController;

class Category {
  final String _name;
  final List<TextEditingController> _words;
  final List<TextEditingController> _hints;
  bool _selected = false;

  Category(
    this._name,
    this._words,
    this._hints,
  );

  factory Category.createCategory(Map<String, dynamic> json) {
    return Category(json["name"], json["words"], json["hints"]);
  }

//==================================    getters   ==================================
  String getName() {
    return _name;
  }
  bool getSelected() {
    return _selected;
  }
  int getLenght() {
    return _words.length;
  }
  String getWord(int index) {
    return _words[index].toString();
  }
  String getHint(int index) {
    return _hints[index].toString();
  }

//==================================    setters  ==================================
  void setSelected(bool selected) {
    _selected = selected;
  }
}