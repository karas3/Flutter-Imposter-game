import 'package:flutter/material.dart';
import 'package:imposter_party_game/src/ui_elements/custom_app_bar.dart';

import 'play_ui.dart';
import '../lobby/lobby_page.dart';
import '../category_managment/category_selection/category_selection_page.dart';

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
      body: Center(
        child: Column(
          children: [
            PlayPageButton(title: "lobby", nextPage: Lobbypage(), rebuildPage: () => setState(() {})),
            PlayPageButton(title: "Category selection", nextPage: CategorySelectionPage()),
            ImposterCounter(),
            StartButton(),
          ],
        ),
      )
    );
  }
}