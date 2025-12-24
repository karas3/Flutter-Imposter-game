import 'package:flutter/material.dart';
import '../../ui_elements/custom_app_bar.dart';

import 'category_edit_ui.dart';
import '../load_categories_from_json.dart';
import '../category_selection/category_selection.dart';

class CategoryEditPage extends StatefulWidget {
  final int id;

  const CategoryEditPage({super.key,
    required this.id,
  });

  @override
  State<CategoryEditPage> createState() => _CategoryEditPageState();
}

class _CategoryEditPageState extends State<CategoryEditPage> {
  final Future<List<Category>> categories = loadCategoryFromJson();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Edit category"),

      body: FutureBuilder(
        future: categories,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
          } 
          else if (!snapshot.hasData) {               // On beggining snapshot has no data which returns unnecessary error
            return Center(child: Text('No Data!'));   
          }
          else {
            final Category category = snapshot.data![widget.id];    // category object

// =========================== PAGE LAYOUT =========================================
            return Column(
              children: [
                CategoryTextHeader(category: category.getName()),

                CategoryTable(category: category)
              ]
            );
          }
        }
      )
    );
  }
}