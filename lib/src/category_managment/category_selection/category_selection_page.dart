import 'package:flutter/material.dart';

import '../../ui_elements/custom_app_bar.dart';
import '../../lobby/lobby_ui.dart' show StartButton;

import '../load_categories_from_json.dart';
import 'category_selection.dart';
import 'category_selection_ui.dart';

class CategorySelectionPage extends StatefulWidget {
  const CategorySelectionPage({super.key});

  @override
  State<CategorySelectionPage> createState() => _CategorySelectionPageState();
}

class _CategorySelectionPageState extends State<CategorySelectionPage> {
// ======================================== LIST OF CATEGORIES ========================================
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
// ======================================== TOP GRAY TEXT ========================================
              Text(
                "Hold to edit category",
                style: TextStyle(
                  color: Color.fromARGB(255, 114, 114, 114)
                ),
              ),

// ======================================== GRID OF CATEGORIES ========================================              
              Flexible(
                child: GridView.count(
                  crossAxisCount: 2,  // 2 columns
                  children: List.generate(snapshot.data!.length, (index) { 
                    return Center(
                      child: CategoryButton(
                        category: snapshot.data![index].getName(),
                        selected: snapshot.data![index].getSelected(),
                        id: index,
                        setSelectedCallback: () {
                          setState(() {
                            snapshot.data![index].getSelected() ? snapshot.data![index].setSelected(false) : snapshot.data![index].setSelected(true);
                          });
                        },  
                      ),
                    );
                  }),
                ),
              ),

// ======================================== START BUTTOn ======================================== 
              StartButton(nextPage: CategorySelectionPage())  //For now placeholder which routes to itself
            ],
          ); 
          }
        }
      ),
    );
  }
}