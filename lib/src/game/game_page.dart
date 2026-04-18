import 'package:flutter/material.dart';
import 'package:imposter_party_game/src/ui_elements/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:imposter_party_game/src/category_managment/category_object.dart';

import 'game_ui.dart';
import 'game_object.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Game page"),
      body: FutureBuilder(
        future: Future.wait([
          context.read<CategoriesList>().allSelectedWords,
          context.read<CategoriesList>().allSelectedHints
        ]),
        builder: (context, AsyncSnapshot<List<List<String>>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Category grid building Error: ${snapshot.error}'));
          } 
          else if (!snapshot.hasData) {               // On beggining snapshot has no data which returns unnecessary error
            return Center(child: Text('Loading Data!'));   
          }
          else {
            return Center(
              child: Provider(
                create: (context) => GameState(snapshot.data![0], snapshot.data![1]),
                builder: (context, child) => Column (
                  children: [
                    Text(
                      "${context.read<GameState>().playerCount.toString()} and ${context.read<GameState>().imposterId.toString()}",
                    ),
                    TestList(),
                    Text(
                      context.read<GameState>().wordsCount.toString(),
                    ),
                    TestList2()
                  ],
                ),
              ),
            );
          }
        }
      ),
    );
  }
}

//TODO: Write an actual game