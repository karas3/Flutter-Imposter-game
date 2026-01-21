import 'package:flutter/services.dart';
import 'dart:convert';

import 'category_object.dart';


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
  final jsonString = await rootBundle.loadString("assets/categories/filesList.json");
  final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
  return jsonMap['files'];
}