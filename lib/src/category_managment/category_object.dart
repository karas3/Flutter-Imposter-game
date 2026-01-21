import 'package:flutter/material.dart';

class Category {
  final String _name;
  final List<dynamic> _words;
  final List<dynamic> _hints;
  final List<TextEditingController> _wordsController = [];
  final List<TextEditingController> _hintsController = [];

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

  TextEditingController getWordController(int index) {
    _wordsController.add(TextEditingController());
    _wordsController[index].text = getWord(index);
    return _wordsController[index];
  }

  TextEditingController getHintController(int index) {
    _hintsController.add(TextEditingController());
    _hintsController[index].text = getHint(index);
    return _hintsController[index];
  }

  void addEntry() {
    _words.add("");
    _hints.add("");
    _wordsController.add(TextEditingController());
    _hintsController.add(TextEditingController());
  }

//==================================    setters  ==================================
  void setSelected(bool selected) {
    _selected = selected;
  }
}