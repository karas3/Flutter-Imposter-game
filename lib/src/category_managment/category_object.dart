import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class Category {
  final String _fileName;   // used for file renaming
  final TextEditingController _name;
  final List<TextEditingController> _wordsList = [];
  final List<TextEditingController> _hintsList = [];
  bool _selected = false;


  //class initialization 
  factory Category.createCategory(Map<String, dynamic> json) {
    return Category(json["name"], json["words"], json["hints"]);
  }

  Category(String name, List<dynamic> words, List<dynamic> hints):
    _fileName = name,
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

  Future<void> saveToJson() async {
    final dir = await getApplicationDocumentsDirectory();
    final targetDir = Directory("${dir.path}/categories");
    final File file = File("${targetDir.path}/$_fileName.json");

    List<String> words = [];
    List<String> hints = [];
    for(int i = 0; i < getLenght(); i++) {
      words.add(getWord(i));
      hints.add(getHint(i));
    }
    Map<String, dynamic> data = {
      "name": getName(),
      "words": words,
      "hints": hints,
    };

    String jsonString = jsonEncode(data);
    try {
      await file.writeAsString(jsonString);
      await file.rename("${targetDir.path}/${getName()}.json");
    } catch (e) {
      print("Error $e");
    }
  }
}