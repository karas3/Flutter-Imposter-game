import 'package:flutter/material.dart';

class Category {
  final String __fileName;
  final TextEditingController _name;
  final List<TextEditingController> _wordsList = [];
  final List<TextEditingController> _hintsList = [];
  bool _selected = false;


  //class initialization 
  factory Category.createCategory(Map<String, dynamic> json) {
    return Category(json["name"], json["words"], json["hints"]);
  }

  Category(String name, List<dynamic> words, List<dynamic> hints):
    __fileName = name,
    _name = TextEditingController(text: name) {
    for (int i = 0; i < words.length; i++) {
      _wordsList.add(TextEditingController());
      _wordsList[i] = TextEditingController(text: words[i]);
      _hintsList.add(TextEditingController());
      _hintsList[i] = TextEditingController(text: hints[i]);
    }
  }

//==================================    getters   ==================================
  String getName() => _name.text;
  TextEditingController getNameController() => _name;

  bool getSelected() => _selected;
  int getLenght() => _wordsList.length;
  String getFileName() => __fileName;
  
  
  String getWord(int index) => _wordsList[index].text;
  String getHint(int index) => _hintsList[index].text;
  
  //used to create table of controllers in category edit page
  TextEditingController getWordController(int index) => _wordsList[index];
  TextEditingController getHintController(int index) =>  _hintsList[index];


//==================================    setters  ==================================
  void setSelected(bool selected) {
    _selected = selected;
  }

  void addEntry() {
    _wordsList.add(TextEditingController());
    _hintsList.add(TextEditingController());
  }

  void removeEntry(int index) {
    _wordsList.removeAt(index);
    _hintsList.removeAt(index);
  }
}