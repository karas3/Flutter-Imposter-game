import 'package:flutter/material.dart';

import '../../ui_elements/custom_app_bar.dart';

import '../save_load_category.dart';
import '../category_object.dart';
import 'category_selection_ui.dart';

class CategorySelectionPage extends StatefulWidget {
  const CategorySelectionPage({super.key});

  @override
  State<CategorySelectionPage> createState() => _CategorySelectionPageState();
}

class _CategorySelectionPageState extends State<CategorySelectionPage> {
  Future<List<Category>> categories = loadCategoryFromJson();   
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Choose categories"),
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
           return Column(
            children: [
              InfoText(),
              CategoriesGrid(categoriesList: snapshot.data!), 
            ],
          ); 
          }
        }
      ),
    );
  }
}