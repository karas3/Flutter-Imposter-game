import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ui_elements/custom_app_bar.dart';

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

  @override
  void initState() {
    super.initState();
    for(int i = 0; i < widget.category.length; i++) {
      _wordsControllers.add(TextEditingController(text: widget.category.words[i]));
      _hintsControllers.add(TextEditingController(text: widget.category.hints[i]));
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}