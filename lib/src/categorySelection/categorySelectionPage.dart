import 'package:flutter/material.dart';

import '../UIElements/customAppBar.dart';
import 'categorySelection.dart';
import 'categorySelectionUI.dart';
import '../lobby/lobbyUI.dart' show StartButton;

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
              Flexible(
                child: GridView.count(
                  crossAxisCount: 2,  // 2 columns
                  children: List.generate(snapshot.data!.length, (index) { 
                    return Center(
                      child: CategoryButton(
                        category: snapshot.data![index].getName(),
                        selected: snapshot.data![index].getSelected(),
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
              StartButton(nextPage: CategorySelectionPage())  //For now placeholder which routes to itself
            ],
          ); 
          }
        }
      ),
    );
  }
}