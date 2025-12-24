import 'package:flutter/material.dart';

import '../category_edit/category_edit_page.dart';

class CategoryButton extends StatefulWidget {
  final String category;
  final Function setSelectedCallback;
  final bool selected;
  final int id;

  const CategoryButton({super.key, 
    required this.category,
    required this.setSelectedCallback,
    required this.selected,
    required this.id,
  });

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  final double size = 170;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,                     
          width: widget.selected ? size : size - 10,  // Entire button width                 
          height: widget.selected ? size : size - 10, // Entire button height
          decoration: BoxDecoration(
            color: widget.selected ? Color.fromARGB(101, 0, 174, 255) : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            border: Border.all(
                color: widget.selected ? const Color.fromARGB(255, 34, 116, 141) :  Color.fromARGB(255, 146, 146, 146),
                width: 3.5,
            ),
          ),
        
          child: TextButton(
            onPressed: () {
              widget.setSelectedCallback();
            },
            onLongPress: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => CategoryEditPage(
                    id: widget.id,
                  ),
                ),
              );
            },
            style: ButtonStyle(
              overlayColor: WidgetStatePropertyAll(Colors.transparent),   // Deletes purple circle which displays for a moment after button is clicked
            ),
            child: AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,   
              style: TextStyle(
                fontSize: widget.selected ? 20 : 18,
              ),
              child: Text(
                widget.category,
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}