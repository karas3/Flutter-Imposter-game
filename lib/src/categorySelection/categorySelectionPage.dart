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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Choose categories"),

      body: Column(
        children: [
          Flexible(
            child: GridView.count(
              crossAxisCount: 2,  // 2 columns
              children: List.generate(categories.length, (index) {  // Generate 100 widgets that display their index in the list.
                return Center(
                  child: CategoryButton(
                    category: categories[index].getName(),
                    selected: categories[index].getSelected(),
                    setSelectedCallback: () {
                      setState(() {
                        categories[index].getSelected() ? categories[index].setSelected(false) : categories[index].setSelected(true);
                      });
                    },  
                  ),
                );
              }),
            ),
          ),
          StartButton(nextPage: CategorySelectionPage())  //For now placeholder which routes to itself
        ],
      ),
    );
  }
}