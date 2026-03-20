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
        color: Theme.of(context).colorScheme.inverseSurface,
      ),
    );
  }
}



// ======================================== GRID OF CATEGORIES ========================================

class CategoriesGrid extends StatefulWidget {
  final List<Category> categoriesList;
  final VoidCallback reloadPage;

  const CategoriesGrid({super.key,
    required this.categoriesList,
    required this.reloadPage,
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
              reloadPage: widget.reloadPage,
            ),
          );
        }),
      ),
    );
  }
}


// ======================================== BUTTON ========================================

class CategoryButton extends StatelessWidget {  //used by CategoriesGrid (code above)
  final String category;
  final VoidCallback setSelectedCallback;
  final bool selected;
  final int id;
  final VoidCallback reloadPage;

  const CategoryButton({super.key, 
    required this.category,
    required this.setSelectedCallback,
    required this.selected,
    required this.id,
    required this.reloadPage,
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
            color: selected ? Theme.of(context).colorScheme.inversePrimary : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            border: Border.all(
                color: selected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outlineVariant,
                width: 3.5,
            ),
          ),
        
          child: TextButton(  // change button style
            onPressed: () {
              setSelectedCallback();
            },
            onLongPress: () {   // switch page to edit_page
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => CategoryEditPage(id: id,),
                ),
              ).then((_) => reloadPage(),);   // used to update name after finishing edition
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
                style: TextStyle(color: Theme.of(context).colorScheme.inverseSurface),
              ),
            ),
          ),
        ),
      ],
    );
  }
}