import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_object.dart';
import 'package:imposter_party_game/src/ui_elements/custom_text.dart';

class TextBox extends StatefulWidget {
  const TextBox({super.key});

  @override
  State<TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> with SingleTickerProviderStateMixin {
  Offset _containerOffset = Offset.zero;
  late final AnimationController _animationController;
  List<Tween<double>> _randomGradientAligment = [Tween(begin: 0.0, end: 1.0), Tween(begin: 0.0, end: 1.0)];

  
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
        GestureDetector(
          onPanUpdate: (details) {
            if(_containerOffset.dy + details.delta.dy > 0) { //prevents _containerOffset becoming negative
              double smoothness = 0.1;  // smaller the value more smooth the ending
              double maxOffset = 160;
              setState(() => _containerOffset = _containerOffset + details.delta / sigmoid(smoothness, maxOffset));
            }
          },
          onPanEnd: (details) {
            setState(() => _containerOffset = Offset.zero);
          },
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) => Container(
              width: 300,
              height: 200,
              transform: Matrix4.translationValues(0, _containerOffset.dy, 0),
              alignment: Alignment(0, _containerOffset.dy),
              decoration: BoxDecoration(
                // color: Theme.of(context).colorScheme.inversePrimary,
                gradient: RadialGradient(
                  colors: [const Color.fromARGB(255, 93, 118, 165), const Color.fromARGB(255, 39, 14, 97)],
                  center: AlignmentGeometry.xy(_randomGradientAligment[0].evaluate(_animationController), _randomGradientAligment[1].evaluate(_animationController)),
                  radius: 0.8
                ),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Icon(
                Icons.arrow_downward_rounded,
                size: 200,
              ),
            ),
          ),
        )
      ],
    );
  }

  double sigmoid(double smoothness, double maxOffset) {
    return 1 + pow((e), smoothness * (_containerOffset.dy - maxOffset)).toDouble();
  }

  void _animationLoop() {
    _animationController.forward().then((_) {
      _animationController.reset();
      setState(() {
          _randomGradientAligment = [Tween(begin: _randomGradientAligment[0].end, end: Random().nextDouble() - 0.5), Tween(begin: _randomGradientAligment[1].end, end: Random().nextDouble() - 0.5)];
      });

      _animationLoop();
    });
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animationLoop();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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