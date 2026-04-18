import 'package:flutter/material.dart';
import 'package:imposter_party_game/src/ui_elements/dialogs.dart';
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

  final double borderWidth = 2;
  final double fontSize = 24;


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
                TableCell(data: "Words", wordData: true, fontSize: widget.fontSize, borderWidth: widget.borderWidth,),
                TableCell(data: "Hints", wordData: false, fontSize: widget.fontSize, borderWidth: widget.borderWidth,),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              prototypeItem: Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(width: widget.borderWidth))),child: TextField(style: TextStyle(fontSize: widget.fontSize))),
              shrinkWrap: true,
              itemCount: widget.wordsControllers.length + 1,
              itemBuilder: (BuildContext context, int index) {  
                if(index < widget.wordsControllers.length) {
                  return Dismissible(
                    key: ValueKey(widget.wordsControllers[index]),
                    direction: DismissDirection.endToStart,
                    onDismissed: (DismissDirection right) => setState(() => widget.removeEntry(index)),
                    background: Container(
                      decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, Colors.red])),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                fontSize: 24
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.delete,
                            ),
                          ),
                        ],
                      )
                    ),
                    child: TableRow(
                      wordText: widget.wordsControllers[index].text, hintText: widget.hintsControllers[index].text,
                      wordController: widget.wordsControllers[index], hintController: widget.hintsControllers[index],
                      fontSize: widget.fontSize, borderWidth: widget.borderWidth,
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

  final double fontSize;
  final double borderWidth;

  const TableRow({super.key,
    required this.wordText,
    required this.hintText,
    required this.wordController,
    required this.hintController,
    required this.fontSize,
    required this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 0,
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          TableCell(data: wordText, wordData: true, controller: wordController, fontSize: fontSize, borderWidth: borderWidth,),
          TableCell(data: hintText, wordData: false, controller: hintController, fontSize: fontSize, borderWidth: borderWidth,),
        ],
      ),
    );
  }

}


// =============================================== TABLE CELL =========================================================
class TableCell extends StatelessWidget {
  final bool wordData;  // drawing border
  final String data;
  final TextEditingController? controller;

  final double fontSize;
  final double borderWidth;

  const TableCell({super.key,
    required this.data,
    required this.wordData,
    required this.fontSize,
    required this.borderWidth,
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
              hintStyle: TextStyle(fontWeight: FontWeight.w300),
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
            fixedSize: WidgetStatePropertyAll(const Size(175, 75)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
            side: WidgetStatePropertyAll(BorderSide(                                                                // set border width and color
              width: 3.5,
              color: Theme.of(context).colorScheme.outlineVariant,
            )),
          ),
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.outlineVariant,
            size: 45,
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
  IconData? icon = Icons.save;
  String text = "Save";

  Future<void> dialogBuilder(BuildContext context, String exceptionTitle, String? excpetionDescription) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return WarningDialog(title: exceptionTitle, description: excpetionDescription,);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 50),
        child: FilledButton.icon(
          iconAlignment: IconAlignment.end,
          onPressed: () async {
            setState(() {
              icon = null;
              text = "Saving";
            });
            List<String> exceptionMessage =  await widget.category.saveToJson(widget.title(), widget.words(), widget.hints());
            if(exceptionMessage.isNotEmpty) {
              setState(() {
                icon = Icons.close;
                text = "Can't save";
              });
              if(context.mounted) {
                await dialogBuilder(context, exceptionMessage[0], exceptionMessage[1]);
              }
              await Future.delayed(Duration(seconds: 1));
              setState(() {
                icon = Icons.save;
                text = "Save";
              });
            } else {
              setState(() {
                icon = Icons.check_rounded;
                text = "Saved";
              });
              await Future.delayed(Duration(seconds: 1));
              setState(() {
                icon = Icons.save;
                text = "Save";
              });
            }
          },

          label: Text(
            text,
            style: TextStyle(
              fontSize: 32,
            ),
          ),

          icon: icon != null
          ? Icon(
            icon,
            size: 32,
          )
          : CircularProgressIndicator(
            constraints: BoxConstraints(maxWidth: 24, maxHeight: 24, minHeight: 20, minWidth: 20), 
            color: Theme.of(context).colorScheme.onPrimary
          ),
        ),
      ),
    );
  }
}