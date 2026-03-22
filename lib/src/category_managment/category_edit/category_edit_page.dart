import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ui_elements/custom_app_bar.dart';

import 'category_edit_ui.dart';
import '../category_object.dart';

class CategoryEditPage extends StatefulWidget {
  final Category category;

  const CategoryEditPage({super.key,
    required this.category,
  });

  @override
  State<CategoryEditPage> createState() => _CategoryEditPageState();
}

class _CategoryEditPageState extends State<CategoryEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Edit category"),
      body: ChangeNotifierProvider(
        create: (_) => CategoriesList(),
        child: Builder(
          builder: (context) {    // to fix an error with provider not existing
        // =========================== PAGE LAYOUT =========================================
            return Column(
              children: [
                CategoryTitle(controller: widget.category.nameController, text: widget.category.name,),
                CategoryTable(category: widget.category),
                SaveButton(category: widget.category),
              ]
            );
          }
        ),
      ),
    );
  }
}