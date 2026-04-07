import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:imposter_party_game/src/ui_elements/custom_app_bar.dart';
import 'category_selection_ui.dart';

import 'package:imposter_party_game/src/category_managment/category_object.dart';

class CategorySelectionPage extends StatefulWidget {
  const CategorySelectionPage({super.key});  

  @override
  State<CategorySelectionPage> createState() => _CategorySelectionPageState();
}

class _CategorySelectionPageState extends State<CategorySelectionPage> {
  @override
  Widget build(BuildContext context) {
    context.watch<CategoriesList>().list; // needs to be here to rebuild page properly
    return Scaffold(
      appBar: CustomAppBar(title: "Choose categories"),
      body:
      Column(
        children: [
          InfoText(),
          CategoriesGrid(), 
        ],
      ),
    );
  }
}