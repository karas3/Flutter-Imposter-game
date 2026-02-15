import 'package:flutter/material.dart';

class Category {
  final String _name;
  final List<dynamic> _words;
  final List<dynamic> _hints;
  final List<TextEditingController> _wordsControllerList = [];
  final List<TextEditingController> _hintsControllerList = [];

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
      _wordsControllerList.add(TextEditingController());
      _wordsControllerList[i].text = getWord(i);
      _hintsControllerList.add(TextEditingController());
      _hintsControllerList[i].text = getHint(i);
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
    return _wordsControllerList.length;
  }
  String getWord(int index) {
    return _words[index].toString();
  }
  String getHint(int index) {
    return _hints[index].toString();
  }

  TextEditingController getWordController(int index) {  //used to create table of controllers in category edit page
    return _wordsControllerList[index];
  }

  TextEditingController getHintController(int index) { //used to create table of controllers in category edit page
    return _hintsControllerList[index];
  }


//==================================    setters  ==================================
  void setSelected(bool selected) {
    _selected = selected;
  }


  void addEntry() {
    _words.add("");
    _hints.add("");
    _wordsControllerList.add(TextEditingController());
    _hintsControllerList.add(TextEditingController());
  }

  void removeEntry(int index) {
    _words.removeAt(index);
    _hints.removeAt(index);
    _wordsControllerList.removeAt(index);
    _hintsControllerList.removeAt(index);
  }
}