import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../category_object.dart';


// =============================================== CATEGORY TITLE =========================================================
class CategoryTitle extends StatelessWidget {
  final TextEditingController controller;

  const CategoryTitle({super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(  // makes width text editing controller same as text in it
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0), //invisible gap between title and table
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: UnderlineInputBorder()
          ),
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// =============================================== TABLE BUILDER =========================================================
class CategoryTable extends StatefulWidget {
  final List<TextEditingController> wordsControllers;
  final List<TextEditingController> hintsControllers;
  final VoidCallback addEntry;
  final Function removeEntry;


  const CategoryTable({super.key,
    required this.wordsControllers,
    required this.hintsControllers,
    required this.addEntry,
    required this.removeEntry,
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
                itemCount: widget.wordsControllers.length + 1,
                itemBuilder: (BuildContext context, int index) {  
                  if(index < widget.wordsControllers.length) {
                    return Slidable (
                      // Specify a key if the Slidable is dismissible.
                      key: const ValueKey(0),
                      endActionPane: ActionPane(
                      extentRatio: 0.25,
                      motion: const DrawerMotion(),
                        children: [
                          SlidableAction(
                            borderRadius: BorderRadius.circular(15),
                            onPressed: (context) => setState(() {widget.removeEntry(index);}),
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
                          CategoryTableMember(data: widget.wordsControllers[index].text, wordData: true, controller: widget.wordsControllers[index]),
                          CategoryTableMember(data: widget.hintsControllers[index].text, wordData: false, controller: widget.hintsControllers[index]),
                        ],
                      ),
                    )
                    );
                  } else {
                    return AddButton(callback: () => setState(() {widget.addEntry();}));
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
    String text;
    if(wordData) {
      paddingRight = 2;
      text = "Enter Word";
    } else {
      paddingLeft = 2;
      text = "Enter Hint";
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
                hintText: text,
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
//==================================    ADD BUTTON    ==================================
class AddButton extends StatelessWidget {
  final VoidCallback callback;
  
  const AddButton({super.key,
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


//==================================    SAVE BUTTON    ==================================
class SaveButton extends StatefulWidget {
  final Category category;
  final ValueGetter title;
  final ValueGetter words;
  final ValueGetter hints;

  const SaveButton({super.key,
    required this.category,
    required this.title,
    required this.words,
    required this.hints,
  });

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  IconData icon = Icons.save;
  String text = "Save";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 50),
        child: OutlinedButton(
          onPressed: () async {
            widget.category.saveToJson(widget.title(), widget.words(), widget.hints());
            // change icon and text to let user know that changes were saved
            setState(() {
              icon = Icons.check_rounded;
              text = "Saved";
            });
            await Future.delayed(Duration(seconds: 1));
            setState(() {
              icon = Icons.save;
              text = "Save";
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 32
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  icon,
                  size: 32,
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}