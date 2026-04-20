import 'package:flutter/material.dart';
import 'package:imposter_party_game/src/ui_elements/custom_app_bar.dart';
import 'package:imposter_party_game/src/ui_elements/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:imposter_party_game/src/category_managment/category_object.dart';

import 'game_ui.dart';
import 'game_object.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Game page"),
      body: FutureBuilder(
        future: Future.wait([
          context.read<CategoriesList>().allSelectedWords,
          context.read<CategoriesList>().allSelectedHints
        ]),
        builder: (context, AsyncSnapshot<List<List<String>>> snapshot) { // AsyncSnapshot<[wordslist, hintslist]>
          if (snapshot.hasError) {
            return Center(child: Text('Category grid building Error: ${snapshot.error}', style: AppTextStyles.standard,));
          } 
          else if (!snapshot.hasData) {               // On beggining snapshot has no data which returns unnecessary error
            return Center(child: Text('Loading Data!', style: AppTextStyles.standard,));   
          }
          else {
            return Provider(
              create: (context) => GameState(snapshot.data![0], snapshot.data![1]), //[words, hints]
              builder: (context, child) => AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) => SlideTransition(position: Tween<Offset>(
                  begin: Offset(1.0, 0.0),
                  end: Offset.zero).animate(animation), child: child,
                ),
                child: Center(
                  key: ValueKey(context.watch<GameState>().currentIndex),
                  child: Column (
                    children: [
                      Text(
                        context.read<GameState>().playerList[context.read<GameState>().currentIndex], style: AppTextStyles.standard,
                      ),
                      TextBox(),
                      NextButton(incrementIndex: () => setState(() => context.read<GameState>().incrementCurrentIndex())),
                    ],
                  ),
                )
              ),
            );
          }
        }
      ),
    );
  }
}

//TODO: Write an actual game