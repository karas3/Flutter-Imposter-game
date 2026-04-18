import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_object.dart';

class TestList extends StatelessWidget {
  const TestList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: context.read<GameState>().playerCount,
      itemBuilder: (context, index) {
        return Text(
          context.read<GameState>().playerList[index].isNotEmpty ? context.read<GameState>().playerList[index] : "no name",
        );
      },
    );
  }
}

class TestList2 extends StatelessWidget {
  const TestList2({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: context.read<GameState>().wordsCount,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Text(
              context.read<GameState>().wordsList[index].isNotEmpty ? "${context.read<GameState>().wordsList[index]} and " : "-",
            ),
            Text(
              context.read<GameState>().hintsList[index].isNotEmpty ? context.read<GameState>().hintsList[index] : "-",
            ),
          ],
        );
      },
    );
  }
}