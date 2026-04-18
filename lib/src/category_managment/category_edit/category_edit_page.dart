import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:imposter_party_game/src/ui_elements/custom_app_bar.dart';
import 'package:imposter_party_game/src/ui_elements/dialogs.dart';

import 'category_edit_ui.dart';
import '../category_object.dart';

class CategoryEditPage extends StatefulWidget {
  final Category category;

  const CategoryEditPage({super.key,
    required this.category,
  });

  @override
  State<CategoryEditPage> createState() => _CategoryEditPageState();
}

class _CategoryEditPageState extends State<CategoryEditPage> {
  late final TextEditingController _titleController = TextEditingController(text: widget.category.name);
  late final List<TextEditingController> _wordsControllers = [];
  late final List<TextEditingController> _hintsControllers = [];
  Future<bool?> dialogBuilder(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(title: "Are you sure you want to leave without saving?", confirmButtonText: "Leave", denyButtonText: "Cancel");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope<Object?>(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if(didPop) {
          return;
        }
        if(checkIfChangesWereMade()) {
          final bool shouldPop = await dialogBuilder(context) ?? false;
          if(context.mounted && shouldPop) {
            Navigator.pop(context);
          }
        } else {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(title: "Edit category"),
        body: ChangeNotifierProvider(
          create: (_) => CategoriesList(),
          child: Builder(
            builder: (context) {    // to fix an error with provider not existing
          // =========================== PAGE LAYOUT =========================================
              return Column(
                children: [
                  CategoryTitle(controller: _titleController),
                  CategoryTable(wordsControllers: _wordsControllers, hintsControllers: _hintsControllers, addEntry: addEntry, removeEntry: removeEntry),
                  SaveButton(category: widget.category, title: () => title, words: () => words, hints: () => hints),
                ]
              );
            }
          ),
        ),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    for(int i = 0; i < widget.category.numberOfWords; i++) {
      _wordsControllers.add(TextEditingController(text: widget.category.words[i]));
      _hintsControllers.add(TextEditingController(text: widget.category.hints[i]));
    }
  }

  bool checkIfChangesWereMade() {
    if(_titleController.text != widget.category.name) return true;  //check for name change
    for(int i = 0; i < _wordsControllers.length; i++) {
      if(i < widget.category.numberOfWords){  //check for old entries
        if(_wordsControllers[i].text != widget.category.words[i] || _hintsControllers[i].text != widget.category.hints[i]) return true; //check if any old entry has a change
      } else {  //check for new entries
        if(_wordsControllers.length != widget.category.words.length) { // check if any new entry was added
          if(_wordsControllers[i].text.isNotEmpty || _hintsControllers[i].text.isNotEmpty) return true; //check if any new entry has a value
        } else {
          return false; // no new entry
        }
      }
    }
    return false; // no change at all
  }

  void addEntry() {
    _wordsControllers.add(TextEditingController());
    _hintsControllers.add(TextEditingController());
  }

  void removeEntry(int index) {
    _wordsControllers[index].dispose();
    _hintsControllers[index].dispose();
    _wordsControllers.removeAt(index);
    _hintsControllers.removeAt(index);
  }

  String get title => _titleController.text;

  List<String> get words {
    final List<String> words = [];
    for(TextEditingController word in _wordsControllers) {
      words.add(word.text);
    }
    return words;
  }

  List<String> get hints {
    final List<String> hints = [];
    for(TextEditingController hint in _hintsControllers) {
      hints.add(hint.text);
    }
    return hints;
  }
  
  @override
  void dispose() {
    _titleController.dispose();
    for(int i = 0; i < _wordsControllers.length; i++) {
      _wordsControllers[i].dispose();
      _hintsControllers[i].dispose();
    }
    super.dispose();
  }
}