import 'package:flutter/material.dart';

import 'lobby_ui.dart';
import '../ui_elements/custom_app_bar.dart';
import '../category_managment/category_selection/category_selection_page.dart';

class Lobbypage extends StatefulWidget {

  const Lobbypage({super.key, 
  });

  @override
  State<Lobbypage> createState() => _LobbypageState();
}

class _LobbypageState extends State<Lobbypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Create Lobby"),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
          //==================================    List of players   ================================== 
            LobbyPlayerInputTileList(),
            StartButton(nextPage: CategorySelectionPage()),
          ],
        ),
      ),
    );
  }
}