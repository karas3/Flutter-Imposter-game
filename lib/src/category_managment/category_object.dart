import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'load_category.dart';

class CategoriesList extends ChangeNotifier {
  final Future<List<Category>> _list = loadCategoryFromJson();

  Future<List<Category>> get list => _list;

  Future<List<String>> get names async {  // used to check if new category name already exists
    List<String> names = [];
    for(Category category in await list) {
      names.add(category.name);
    }
    return names;
  }

  Future<bool> get isAnySelected async {   // used to prevent game from starting if no category selected
    for(Category category in await _list) {
      if(category.isSelected) return true;
    }
    return false;
  }
  
    Future<bool> isCategoryEmpty(int index) async {
      if((await list)[index].words.isEmpty || (await list)[index].hints.isEmpty) return true;
      return false;
    }

  Future<List<String>> get allSelectedWords async { //used for game page
    List<String> words = [];
    for(Category category in await list) {
      if(category.isSelected) {
        for(String word in category.words) {
          if(word.isEmpty) {
            words.add("-");
          } else {
            words.add(word);
          }
        }
      }
    }
    return words;
  }

  Future<List<String>> get allSelectedHints async { //used for game page
    List<String> hints = [];
    for(Category category in await list) {
      if(category.isSelected) {
        for(String hint in category.hints) {
          if(hint.isEmpty) {
            hints.add("-");
          } else {
            hints.add(hint);
          }
        }
      }
    }
    return hints;
  }

  void add() async {
    final List<Category> list = await _list;
    list.add(Category("Empty ${list.length + 1}", [], []));
    notifyListeners();
  }

  void removeAt(int index) async {
    final List<Category> list = await _list;
    final fileName = list[index].name;

    //remove from list
    list.removeAt(index);

    // delete file
    final dir = await getApplicationDocumentsDirectory();
    final targetDir = Directory("${dir.path}/categories");
    final File file = File("${targetDir.path}/$fileName.json");
    if(await file.exists()) {
      file.delete();
    }
  }
}



class Category extends ChangeNotifier {
  String _name;
  List<String> _words = [];
  List<String> _hints = [];
  bool _selected = false;

  //class initialization
  factory Category.createCategory(Map<String, dynamic> json) => Category(json["name"], json["words"], json["hints"]);

  Category(String name, List<dynamic> words, List<dynamic> hints): 
      _name = name {
    for (int i = 0; i < words.length; i++) {
      _words.add(words[i]);
      _hints.add(hints[i]);
    }
  }
  
  void switchSelected() {
    _selected ? _selected = false : _selected = true;
  }

  //==================================    GETTERS   ==================================
  String get name => _name;
  int get numberOfWords => _words.length;
  List<String> get words => _words;
  List<String> get hints => _hints;
  bool get isSelected => _selected;

// ============================= SAVE ========================================
  Future<List<String>> saveToJson(String newName, List<String> words, List<String> hints, List<String> allNames) async {
    final dir = await getApplicationDocumentsDirectory();
    final targetDir = Directory("${dir.path}/categories");
    final File file = File("${targetDir.path}/$_name.json");  // _name is name of file

// check for errors and exceptions
    for(int i = 0; i < words.length; i++) { // check for empty word hint pair
      if(words[i].isEmpty && hints[i].isEmpty) {
        words.removeAt(i);
        hints.removeAt(i);
      }
    }
    for(int i = 0; i < words.length; i++) { //check for hint without a word
      if(words[i].isEmpty && hints[i].isNotEmpty) {
        return ["Can't leave hint without a word", ""];
      }
    }
    if(!RegExp(r'^[a-zA-Z0-9 _\-\.]+$').hasMatch(newName)) { //check for special characters
      return ["Category name Can't use special characters", "Only characters allowed are letters, numbers, _, -, ."];
    }

    if(newName != name) { // check if category with same name exists
      for(String name in allNames) {
        if(newName == name) {
          return ["Category with this name already exists", ""];
        }
      } 
    }


    Map<String, dynamic> data = {
      "name": newName,
      "words": words,
      "hints": hints,
    };

    String jsonString = jsonEncode(data);
    try {
      await file.writeAsString(jsonString);
      await file.rename("${targetDir.path}/$newName.json");
    } catch (e) {
      return ["Error $e"];
    }

    // Update variables after saving
    _name = newName;
    _words = words;
    _hints = hints;

    return [];  //no exceptions
  }
}