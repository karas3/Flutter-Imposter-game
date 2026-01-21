import 'package:flutter/material.dart';

import '../category_edit/category_edit_page.dart';
import '../category_object.dart';


class InfoText extends StatelessWidget {
  const InfoText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Hold to edit category",
      style: TextStyle(
        color: Color.fromARGB(255, 114, 114, 114)
      ),
    );
  }
}



// ======================================== GRID OF CATEGORIES ========================================
class CategoriesGrid extends StatefulWidget {
  final List<Category> categoriesList;

  const CategoriesGrid({super.key,
    required this.categoriesList,
  });

  @override
  State<CategoriesGrid> createState() => _CategoriesGridState();
}

class _CategoriesGridState extends State<CategoriesGrid> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.count(
        crossAxisCount: 2,  // 2 columns
        children: List.generate(widget.categoriesList.length, (index) { 
          return Center(
            child: CategoryButton(
              category: widget.categoriesList[index].getName(),
              selected: widget.categoriesList[index].getSelected(),
              id: index,
              setSelectedCallback: () {
                setState(() {
                  widget.categoriesList[index].getSelected() ? widget.categoriesList[index].setSelected(false) : widget.categoriesList[index].setSelected(true);
                });
              },  
            ),
          );
        }),
      ),
    );
  }
}



class CategoryButton extends StatelessWidget {
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

  final double size = 170;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,                     
          width: selected ? size : size - 10,  // Entire button width                 
          height: selected ? size : size - 10, // Entire button height
          decoration: BoxDecoration(
            color: selected ? Color.fromARGB(101, 0, 174, 255) : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            border: Border.all(
                color: selected ? const Color.fromARGB(255, 34, 116, 141) :  Color.fromARGB(255, 146, 146, 146),
                width: 3.5,
            ),
          ),
        
          child: TextButton(
            onPressed: () {
              setSelectedCallback();
            },
            onLongPress: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => CategoryEditPage(
                    id: id,
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
                fontSize: selected ? 20 : 18,
              ),
              child: Text(
                category,
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}