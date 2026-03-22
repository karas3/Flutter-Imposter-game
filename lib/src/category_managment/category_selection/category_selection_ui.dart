import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        children: List.generate(widget.categoriesList.length + 1, (index) { 
          if(index < widget.categoriesList.length) {
            return Center(
            child: CategoryButton(
              categoriesList: widget.categoriesList,
              id: index,
              setSelectedCallback: () {
                setState(() {
                  widget.categoriesList[index].selected ? widget.categoriesList[index].setSelected(false) : widget.categoriesList[index].setSelected(true);
                });
              },  
            ),
          );
          } else {
            return Center(
              child: AddCategoryButton()
            );
          }
        }),
      ),
    );
  }
}


// ======================================== BUTTON ========================================

class CategoryButton extends StatelessWidget {  //used by CategoriesGrid (code above)
  final VoidCallback setSelectedCallback;
  final int id;
  final List<Category> categoriesList;

  const CategoryButton({super.key, 
    required this.setSelectedCallback,
    required this.id,
    required this.categoriesList
  });

  final double size = 170;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,                     
          width: categoriesList[id].selected ? size : size - 10,   //170, 160                 
          height: categoriesList[id].selected ? size : size - 10,
          decoration: BoxDecoration(  
            color: categoriesList[id].selected ? Theme.of(context).colorScheme.inversePrimary : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            border: Border.all(
                color: categoriesList[id].selected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outlineVariant,
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
                  builder: (context) => CategoryEditPage(category: categoriesList[id]),
                ),
              ).then((_) => context.read<CategoriesList>().reload());   // used to update name after finishing edition
            },
            style: ButtonStyle(
              overlayColor: WidgetStatePropertyAll(Colors.transparent),   // Deletes purple circle which displays for a moment after button is clicked
            ),
            child: AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,   
              style: TextStyle(
                fontSize: categoriesList[id].selected ? 20 : 18,
              ),
              child: Text(
                categoriesList[id].name,
                style: TextStyle(color: Theme.of(context).colorScheme.inverseSurface),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



//==================================    ADD BUTTON (grey transparent one)   ==================================
class AddCategoryButton extends StatelessWidget {
  
  const AddCategoryButton({super.key,
   });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(
        child: FilledButton(
          onPressed: () {
            context.read<CategoriesList>().add();
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.surface),
            fixedSize: WidgetStatePropertyAll(const Size(160,160)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
            side: WidgetStatePropertyAll(BorderSide(                                                                // set border width and color
              width: 3.5,
              color: Theme.of(context).colorScheme.outlineVariant,
            )),
          ),
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.outlineVariant,
            size: 75,
          ),
        ),
      ),
    );
  }
}