import 'package:flutter/material.dart';
import 'package:imposter_party_game/src/ui_elements/custom_app_bar.dart';
import 'game_ui.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Game page"),
      body: Center(
        child: Text(
          "GamePage"
        ),
      ),
    );
  }
}

//TODO: Write an actual game