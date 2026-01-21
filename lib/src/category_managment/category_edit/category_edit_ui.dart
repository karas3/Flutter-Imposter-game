import 'package:flutter/material.dart';
import '../category_object.dart';

class CategoryTextHeader extends StatelessWidget {
  final String category;

  const CategoryTextHeader({super.key,
    required this.category
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Category: $category",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
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
              CategoryTableHeader(data: "Words", wordData: true),
              CategoryTableHeader(data: "Hints", wordData: false),
            ],
          ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Color.fromARGB(153, 56, 56, 56), Theme.of(context).colorScheme.surface], begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: [0.5, 0.95])
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.category.getLenght() + 1,
                itemBuilder: (BuildContext context, int index) {  
                  if(index < widget.category.getLenght()) {
                    return Row(
                      children: [
                        CategoryTableMember(data: widget.category.getWord(index), wordData: true, controller: widget.category.getWordController(index)),
                        CategoryTableMember(data: widget.category.getHint(index), wordData: false, controller: widget.category.getHintController(index)),
                      ],
                    );
                  } else {
                    return AddWordHintPairButton(callback: () {
                      setState(() {
                        widget.category.addEntry();
                      });
                    });
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



class CategoryTableHeader extends StatelessWidget {
  final double fontSize = 24;

  final bool wordData;  // drawing border
  final String data;

  const CategoryTableHeader({super.key,
    required this.data,
    required this.wordData,
  });

  @override
  Widget build(BuildContext context) {
    double paddingLeft = 0;
    double paddingRight = 0;
    if(wordData) {
      paddingRight = 2;
    } else {
      paddingLeft = 2;
    }

    return Expanded(
      flex: 5,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 4, color: Color.fromARGB(153, 56, 56, 56)), 
            left: BorderSide(width: paddingLeft, color: Color.fromARGB(153, 56, 56, 56)),
            right: BorderSide(width: paddingRight, color: Color.fromARGB(153, 56, 56, 56)), 
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
    String _hint;
    if(wordData) {
      paddingRight = 2;
      _hint = "Enter Word";
    } else {
      paddingLeft = 2;
      _hint = "Enter Hint";
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
                hintText: _hint,
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
//==================================    Add player button (grey transparent one)   ==================================
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
              color: Color.fromARGB(52, 0, 0, 0),
            )),
          ),
          child: Icon(
            Icons.add,
            color: Colors.grey,
            size: 75,
          ),
        ),
      ),
    );
  }
}