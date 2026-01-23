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

  void init() {
    for (int i = 0; i < _words.length; i++) {
      _wordsController.add(TextEditingController());
      _wordsController[i].text = getWord(i);
      _hintsController.add(TextEditingController());
      _hintsController[i].text = getHint(i);
    }
  }

//==================================    getters   ==================================
  String getName() {
    init();
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

  TextEditingController getWordController(int index) {  //used to create table of controllers in category edit page
    return _wordsController[index];
  }

  TextEditingController getHintController(int index) { //used to create table of controllers in category edit page
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