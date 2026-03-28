import 'package:flutter/material.dart';
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
    return Expanded( 
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 5.0 , color: Theme.of(context).colorScheme.outline))
            ),
            child: Row(
              children: [
                TableCell(data: "Words", wordData: true,),
                TableCell(data: "Hints", wordData: false),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              prototypeItem: TableRow(wordText: widget.wordsControllers[0].text, hintText: widget.hintsControllers[0].text, wordController: widget.wordsControllers[0], hintController: widget.hintsControllers[0],),
              shrinkWrap: true,
              itemCount: widget.wordsControllers.length + 1,
              itemBuilder: (BuildContext context, int index) {  
                if(index < widget.wordsControllers.length) {
                  return Dismissible(
                    key: ValueKey(widget.wordsControllers[index]),
                    onDismissed: (DismissDirection direction) => setState(() => widget.removeEntry(index)),
                    child: TableRow(
                      wordText: widget.wordsControllers[index].text, hintText: widget.hintsControllers[index].text,
                      wordController: widget.wordsControllers[index], hintController: widget.hintsControllers[index],
                    ),
                  );
                } else {
                  return AddButton(addEntry: () => setState(() => widget.addEntry()));
                }
              }
            ),
          ),
        ],
      ),
    );
  }
}
// =============================================== TABLE ROW =========================================================
class TableRow extends StatelessWidget {
  final String wordText;
  final String hintText;
  final TextEditingController wordController;
  final TextEditingController hintController;

  const TableRow({super.key,
    required this.wordText,
    required this.hintText,
    required this.wordController,
    required this.hintController,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 0,
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          TableCell(data: wordText, wordData: true, controller: wordController),
          TableCell(data: hintText, wordData: false, controller: hintController),
        ],
      ),
    );
  }

}


// =============================================== TABLE CELL =========================================================
class TableCell extends StatelessWidget {
  final double fontSize = 24;
  final double borderWidth = 2;

  final bool wordData;  // drawing border
  final String data;
  final TextEditingController? controller;

  const TableCell({super.key,
    required this.data,
    required this.wordData,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor = Theme.of(context).colorScheme.outline;

    return Expanded(
      child: Center(
        child: controller != null
        ?Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: borderWidth , color: borderColor), left: BorderSide(width: wordData ? 0 : borderWidth / 2, color: borderColor), right: BorderSide(width: wordData ? borderWidth / 2 : 0, color: borderColor)),
          ),
          child: TextFormField(                   //input field
            controller: controller,
            decoration: InputDecoration(
              hintText: wordData ? "Enter word" : "Enter hint",
              hintStyle: TextStyle(fontWeight: FontWeight(2)),
            ),
            style: TextStyle(
              fontSize: 24
            ),
          ),
        ) 
        :Text(
          data,    
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}



//==================================    ADD BUTTON    ==================================
class AddButton extends StatelessWidget {
  final VoidCallback addEntry;
  
  const AddButton({super.key,
    required this.addEntry,
   });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(
        child: FilledButton(
          onPressed: () => addEntry(),
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
//TODO: rewerite look of this button
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