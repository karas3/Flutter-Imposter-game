import 'dart:io';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import 'category_object.dart';

Future<List<Category>> loadCategoryFromJson() async {
  final dir = await getApplicationDocumentsDirectory();
  final targetDir = Directory("${dir.path}/categories");

  List<FileSystemEntity> categoriesJsonFiles = await targetDir.list().toList();
  List<Category> categories = [];
  for(final FileSystemEntity file in categoriesJsonFiles) {
    final jsonString = await File(file.path).readAsString();
    final jsonMap = jsonDecode(jsonString);
    categories.add(Category.createCategory(jsonMap));
  }
  return categories;
}


// checks if assets are present inside app document directory so later they can be edited if not adds them
Future<void> ensureDefaultCateogryExists() async {
  final dir = await getApplicationDocumentsDirectory();
  final targetDir = Directory("${dir.path}/categories");

  if(await targetDir.exists()) {  //check if category directory exists in app documents directory, if not create it
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