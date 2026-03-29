import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui_elements/custom_app_bar.dart';
import '../category_object.dart';
import 'category_selection_ui.dart';

class CategorySelectionPage extends StatefulWidget {
  const CategorySelectionPage({super.key});  

  @override
  State<CategorySelectionPage> createState() => _CategorySelectionPageState();
}

class _CategorySelectionPageState extends State<CategorySelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Choose categories"),
      body: ChangeNotifierProvider(
        create: (_) => CategoriesList(),
        builder: (context, child) { 
          context.watch<CategoriesList>().list; // needs to be here to rebuild page properly
          return Column(
            children: [
              InfoText(),
              CategoriesGrid(), 
            ],
          ); 
        }
      ),
    );
  }
}