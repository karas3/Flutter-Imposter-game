import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_object.dart';
import 'package:imposter_party_game/src/ui_elements/custom_text.dart';

class TextBox extends StatelessWidget {
  const TextBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        Column(
          children: [
            Text(
              context.read<GameState>().isImposter ? "You're an imposter" : "You are a civilian",
              style: AppTextStyles.standard,
            ),
            Text(
              context.read<GameState>().isImposter ? "Your hint is:" : "Your word is:",
              style: AppTextStyles.standard,
            ),
            Text(
              context.read<GameState>().isImposter ? context.read<GameState>().hint : context.read<GameState>().word,
              style: AppTextStyles.standard,
            )
          ],
        ),
        Draggable(  //TODO: this is a placehodler, write an actual working thing
          axis: Axis.vertical,
          maxSimultaneousDrags: 1,
          feedback: Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              borderRadius: BorderRadius.all(Radius.circular(30))
            ),
            child: Icon(
              Icons.arrow_downward_rounded,
              size: 200,
            ),
          ),
          childWhenDragging: SizedBox(
            width: 300,
            height: 200,
          ),

          child: Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Icon(
              Icons.arrow_downward_rounded,
              size: 200,
            ),
          ),
        ),
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
          "Next player",
          style: AppTextStyles.standard,
        ),
      )
    : FilledButton(
      onPressed: () => (),
      child: Text(
        "Start",
        style: AppTextStyles.standard,
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