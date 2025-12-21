import 'package:flutter/services.dart';
import 'dart:convert';

Future<List<Category>> loadCategoryFromJson() async {
  List<Category> categories = [];
  List<dynamic> filesList = await getFilesList();

  for(int i = 0; i < filesList.length; i++) {
    final jsonString = await rootBundle.loadString("assets/categories/${filesList[i]}");
    final jsonMap = jsonDecode(jsonString);
    categories.add(Category.createCategory(jsonMap));
  }

  return categories;
}

Future<List<dynamic>> getFilesList() async {
  final _jsonString = await rootBundle.loadString("assets/categories/filesList.json");
  final Map<String, dynamic> _jsonMap = jsonDecode(_jsonString);
  return _jsonMap['files'];
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

  factory Category.createCategory(Map<String, dynamic> json) {
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