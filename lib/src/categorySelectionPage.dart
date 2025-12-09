import 'package:flutter/material.dart';

import 'UIElements/customAppBar.dart';

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

      body: Center(
        child: Text(
          "Category selection page",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
    );
  }
}