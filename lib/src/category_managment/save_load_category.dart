import 'dart:io';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import 'category_object.dart';

Future<List<Category>> loadCategoryFromJson() async {
  final dir = await getApplicationDocumentsDirectory();
  final targetDir = Directory("${dir.path}/categories");

  final List<FileSystemEntity> categoriesJsonFiles = await targetDir.list().toList();
  List<Category> categories = [];
  for(final FileSystemEntity file in categoriesJsonFiles) {
    final jsonString = await File(file.path).readAsString();
    final jsonMap = jsonDecode(jsonString);
    categories.add(Category.createCategory(jsonMap));
  }

  return categories;
}


Future<void> saveToJson(Category category) async {
  final dir = await getApplicationDocumentsDirectory();
  final targetDir = Directory("${dir.path}/categories");
  final File path = File("${targetDir.path}/${category.getFileName()}.json");

  List<String> words = [];
  List<String> hints = [];
  for(int i = 0; i < category.getLenght(); i++) {
    words.add(category.getWord(i));
    hints.add(category.getHint(i));
  }
  Map<String, dynamic> data = {
    "name": category.getName(),
    "words": words,
    "hints": hints,
  };

  String jsonString = jsonEncode(data);
  try {
    await path.writeAsString(jsonString);
    await path.rename("${targetDir.path}/${category.getName()}.json");
  } catch (e) {
    print("Error $e");
  }
}


// checks if assets are present inside app document directory so later they can be edited if not adds them
Future<void> defaultCateogryExists() async {
  final dir = await getApplicationDocumentsDirectory();
  final targetDir = Directory("${dir.path}/categories");

  if(await targetDir.exists()) {  //check if category directory exists in app documents directory if not create  it
    return;         // Delete this line to return to default state of files
  }
  await targetDir.create();
  final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
  final categoryAssetsPaths = manifest.listAssets().where((path) => path.startsWith("assets/categories/")).toList();

  for(final categoryFile in categoryAssetsPaths) {        //copy files from assets to app documents directory
    final String fileName = categoryFile.split("/").last;
    final newFile = File("${targetDir.path}/$fileName");
    final data = await rootBundle.loadString(categoryFile);
    await newFile.writeAsString(data);
  }
}