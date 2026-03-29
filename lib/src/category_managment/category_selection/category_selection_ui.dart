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
        backgroundColor: Colors.transparent,
        color: Theme.of(context).colorScheme.inverseSurface,
      ),
    );
  }
}



// ======================================== GRID OF CATEGORIES ========================================

class CategoriesGrid extends StatefulWidget {
  const CategoriesGrid({super.key});

  @override
  State<CategoriesGrid> createState() => _CategoriesGridState();
}

class _CategoriesGridState extends State<CategoriesGrid> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<CategoriesList>().list, 
      builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Category grid building Error: ${snapshot.error}'));
        } 
        else if (!snapshot.hasData) {               // On beggining snapshot has no data which returns unnecessary error
          return Center(child: Text('Loading Data!'));   
        }
        else {
          return Flexible(
            child: GridView.count(
              crossAxisCount: 2,  // 2 columns
              children: List.generate(snapshot.data!.length + 1, (index) { 
                if(index < snapshot.data!.length) {
                  return Dismissible(
                    key: ValueKey(snapshot.data![index]),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) async {
                      return await _dialogBuilder(context, index);
                    },
                    onDismissed: (direction) {
                      context.read<CategoriesList>().removeAt(index);
                      setState(() {});
                    },
                    child: Center(
                      child: CategoryButton(
                        categoriesList: snapshot.data!,
                        id: index,
                        setSelectedCallback: () {
                          setState(() {
                            snapshot.data![index].switchSelected();
                          });
                        },  
                      ),
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
    );
  }

  Future<bool?> _dialogBuilder(BuildContext context, index) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Are you sure you want to delete this Category?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24
            ),
          ),
          content: const Text(
            "This action can not be undone!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    FilledButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                          fontSize: 24
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: OutlinedButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 24
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
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
        
          child: TextButton(
            onPressed: () => setSelectedCallback(),
            onLongPress: () {   // switch page to edit_page
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => CategoryEditPage(category: categoriesList[id]),
                ),
              ).then((_) { 
                if(context.mounted) context.read<CategoriesList>().reload();
              });   
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