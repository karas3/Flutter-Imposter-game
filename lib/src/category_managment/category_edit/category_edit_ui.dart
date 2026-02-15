import 'package:flutter/material.dart';
import '../category_object.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


// =============================================== CATEGORY TITLE =========================================================
class CategoryTextHeader extends StatelessWidget {
  final String category;

  const CategoryTextHeader({super.key,
    required this.category
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0), //invisible gap between title and table
      child: Text(
        "Category: $category",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}


// =============================================== TABLE BUILDER =========================================================
class CategoryTable extends StatefulWidget {
  final Category category;

  const CategoryTable({super.key,
    required this.category,
  });

  @override
  State<CategoryTable> createState() => _CategoryTableState();
}

class _CategoryTableState extends State<CategoryTable> {
  @override
  Widget build(BuildContext context) {
    return Expanded(  // Fixes list view builder parent not having size
      child: Column(
        children: [
          Row(
            children: [
              CategoryTableHeader(data: "Words"),
              CategoryTableHeader(data: "Hints"),
            ],
          ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Theme.of(context).colorScheme.outline, Theme.of(context).colorScheme.surface], begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: [0.5, 0.95])
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.category.getLenght() + 1,
                itemBuilder: (BuildContext context, int index) {  
                  if(index < widget.category.getLenght()) {
                    
                    return Slidable (
                      // Specify a key if the Slidable is dismissible.
                      key: const ValueKey(0),
                      endActionPane: ActionPane(
                      extentRatio: 0.25,
                      motion: const DrawerMotion(),

                        children: [
                          SlidableAction(
                            borderRadius: BorderRadius.circular(15),
                            onPressed: (context) => setState(() {widget.category.removeEntry(index);}),
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),

                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child: ListTile(
                        minVerticalPadding: 0,
                        contentPadding: EdgeInsets.zero,
                        title: Row(
                        children: [
                          CategoryTableMember(data: widget.category.getWord(index), wordData: true, controller: widget.category.getWordController(index)),
                          CategoryTableMember(data: widget.category.getHint(index), wordData: false, controller: widget.category.getHintController(index)),
                        ],
                      ),
                    )
                    );
                  } else {
                    return AddWordHintPairButton(callback: () => setState(() {widget.category.addEntry();}));
                  }
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// =============================================== TOP TABLE CELLS =========================================================
class CategoryTableHeader extends StatelessWidget {
  final double fontSize = 24;
  final String data;

  const CategoryTableHeader({super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {


    return Expanded(
      flex: 5,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 4, color: Theme.of(context).colorScheme.outline), 
          ),
        ),
        child: Center(
          child: Text(
            data,    
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}


// =============================================== TABLE CELLS =========================================================
class CategoryTableMember extends StatelessWidget {
  final double fontSize = 24;

  final bool wordData;  // drawing border
  final String data;
  final TextEditingController controller;

  const CategoryTableMember({super.key,
    required this.data,
    required this.wordData,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // to set where to draw border
    double paddingLeft = 0;
    double paddingRight = 0;
    String hint;
    if(wordData) {
      paddingRight = 2;
      hint = "Enter Word";
    } else {
      paddingLeft = 2;
      hint = "Enter Hint";
    }

// ====================================================== TEXT FILEDS ======================================================
    return Expanded(
      flex: 5,
      child: Padding(
        padding: EdgeInsets.only(left: paddingLeft, right: paddingRight),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Center(
            child: TextFormField(                   //input field
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                border: UnderlineInputBorder(),
              ),
              style: TextStyle(
                fontSize: 24
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//==================================    ADD PLAYER BUTTON (grey transparent one)   ==================================
class AddWordHintPairButton extends StatelessWidget {
  final VoidCallback callback;
  
  const AddWordHintPairButton({super.key,
    required this.callback,
   });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(
        child: FilledButton(
          onPressed: () {
            callback();
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.surface),
            fixedSize: WidgetStatePropertyAll(const Size(250, 75)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
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