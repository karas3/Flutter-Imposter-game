import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_object.dart';

class TextBox extends StatelessWidget {
  const TextBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.read<GameState>().isImposter ? "You're an imposter" : "You are a civilian",
        ),
        Text(
          context.read<GameState>().isImposter ? "Your hint is:" : "Your word is:",
        ),
        Text(
          context.read<GameState>().isImposter ? context.read<GameState>().hint : context.read<GameState>().word,
        )
      ],
    );
  }
}


class NextButton extends StatelessWidget {
  final VoidCallback incrementIndex;

  const NextButton({super.key,
    required this.incrementIndex,
  });

  @override
  Widget build(BuildContext context) {
    return context.read<GameState>().currentIndex + 1 < context.read<GameState>().playerCount 
    ? FilledButton(
        onPressed: () => incrementIndex(),
        child: Text(
          "Next player"
        ),
      )
    : FilledButton(
      onPressed: () => (),
      child: Text(
        "Start"
      ),
    );
  }
}


// class TestList extends StatelessWidget {
//   const TestList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: context.read<GameState>().playerCount,
//       itemBuilder: (context, index) {
//         return Text(
//           "${context.read<GameState>().playerList[index]} is: ${context.read<GameState>().whoIs(index)}",
//         );
//       },
//     );
//   }
// }