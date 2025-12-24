import 'package:flutter/material.dart';
import '../category_selection/category_selection.dart';

class CategoryTextHeader extends StatefulWidget {
  final String category;

  const CategoryTextHeader({super.key,
    required this.category
  });

  @override
  State<CategoryTextHeader> createState() => _CategoryTextHeaderState();
}

class _CategoryTextHeaderState extends State<CategoryTextHeader> {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Category: ${widget.category}",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}



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
              CategoryTableMember(data: "Words", header: true, layoutLeft: true),
              CategoryTableMember(data: "Hints", header: true, layoutLeft: false),
            ],
          ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Color.fromARGB(153, 56, 56, 56), Color.fromARGB(255, 228, 228, 228)], begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: [0.5, 0.95])
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.category.getLenght(),
                itemBuilder: (BuildContext context, int index) {  
                  return Row(
                    children: [
                      CategoryTableMember(data: widget.category.getWord(index), header: false, layoutLeft: true),
                      CategoryTableMember(data: widget.category.getHint(index), header: false, layoutLeft: false),
                    ],
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class CategoryTableMember extends StatefulWidget {
  final double fontSize = 24;

  final bool header;
  final bool layoutLeft;  // drawing border
  final String data;

  const CategoryTableMember({super.key,
    required this.data,
    required this.layoutLeft,
    required this.header
  });

  @override
  State<CategoryTableMember> createState() => _CategoryTableMemberState();
}

class _CategoryTableMemberState extends State<CategoryTableMember> {
  @override
  Widget build(BuildContext context) {

    // to set where to draw border
    double paddingLeft = 0;
    double paddingRight = 0;
    if(widget.layoutLeft) {
      paddingRight = 2;
    } else {
      paddingLeft = 2;
    }

    if(widget.header) {
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
              widget.data,    
              style: TextStyle(
                fontSize: widget.fontSize,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      );
    } else {
      return Expanded(
        flex: 5,
        child: Padding(
          padding: EdgeInsets.only(left: paddingLeft, right: paddingRight),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 228, 228, 228)
            ),
            child: Center(
              child: TextFormField(                   //input field
                initialValue: widget.data,
                decoration: InputDecoration(
                  hintText: "Input Words",
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
}