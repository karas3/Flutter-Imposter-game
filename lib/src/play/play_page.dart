import 'package:flutter/material.dart';
import 'package:imposter_party_game/src/category_managment/category_object.dart';
import 'package:provider/provider.dart';

import 'package:imposter_party_game/src/ui_elements/custom_app_bar.dart';
import '../lobby/lobby_page.dart';
import '../category_managment/category_selection/category_selection_page.dart';


import 'play_ui.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({super.key});

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Game rules"),
      body: ChangeNotifierProvider(
        create: (_) => CategoriesList(),
        builder: (context, child) { 
          return Center(
            child: Column(
              children: [
                PlayPageButton(title: "lobby", nextPage: Lobbypage(), rebuildPage: () => setState(() {})),  // rebuild page to update imposter counter and number of players
                PlayPageButton(title: "Category selection", nextPage: CategorySelectionPage(),rebuildPage: () => setState(() {})),  // rebuild page to check if any category is selected
                ImposterCounter(),
                ShufflePlayersCheckBox(),
                StartButton(),
              ],
            ),
          );
        }
      )
    );
  }
}