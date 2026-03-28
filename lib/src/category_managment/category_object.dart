import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'load_category.dart';

class CategoriesList extends ChangeNotifier {
  Future<List<Category>> _list = loadCategoryFromJson();

  void reload() {   
    _list = loadCategoryFromJson();
    notifyListeners();
  }

  Future<List<Category>> get list => _list;

  void add() async {
    final List<Category> list = await _list;
    list.add(Category("Empty ${list.length + 1}", [], []));
    notifyListeners();
  }

  void remove(int index) async {
    final List<Category> list = await _list;
    list.removeAt(index);
  }
}

class Category extends ChangeNotifier {
  final String _name;
  final List<String> _words = [];
  final List<String> _hints = [];
  bool _selected = false;

  //class initialization
  factory Category.createCategory(Map<String, dynamic> json) {
    return Category(json["name"], json["words"], json["hints"]);
  }

  Category(String name, List<dynamic> words, List<dynamic> hints): 
      _name = name {
    for (int i = 0; i < words.length; i++) {
      _words.add(words[i]);
      _hints.add(hints[i]);
    }
  }

  //==================================    GETTERS   ==================================
  String get name => _name;
  int get length => _words.length;
  List<String> get words => _words;
  List<String> get hints => _hints;
  bool get selected => _selected;
  
  void switchSelected() {
    _selected ? _selected = false : _selected = true;
  }

// ============================= SAVE ========================================
  Future<void> saveToJson(String newName, List<String> words, List<String> hints) async {
    final dir = await getApplicationDocumentsDirectory();
    final targetDir = Directory("${dir.path}/categories");
    final File file = File("${targetDir.path}/$_name.json");  // _name is name of file

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
      print("Error $e");
    }
  }
}
