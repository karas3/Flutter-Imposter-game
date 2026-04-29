import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_object.dart';
import 'package:imposter_party_game/src/ui_elements/custom_text.dart';

import 'custom_gradient_background.dart';


class TextBox extends StatefulWidget {
  const TextBox({super.key});

  @override
  State<TextBox> createState() => _TextBoxState();
}
class _TextBoxState extends State<TextBox> with SingleTickerProviderStateMixin {
  double _containerOffset = 0.0;
  late final AnimatedGradient _gradient;
  
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
            if(_containerOffset + details.delta.dy > 0) { //prevents _containerOffset becoming negative
              double smoothness = 0.1;  // smaller the value more smooth the ending
              double maxOffset = 160;
              setState(() {
                _containerOffset = _containerOffset + details.delta.dy / sigmoid(smoothness, maxOffset, _containerOffset);
              });
            }
          },
          onPanEnd: (details) {
            setState(() => _containerOffset = 0);
          },
          child: Container(
            width: 300,
            height: 150,
            transform: Matrix4.translationValues(0, _containerOffset, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: [BoxShadow(color: Colors.black.withAlpha(255), blurRadius: 10.0, offset: Offset(5, 5))],
            ),
            child: _gradient,
          ),
        )
      ],
    );
  }

  double sigmoid(double smoothness, double maxOffset, double currentOffset) {
    assert(maxOffset > 0, "max offset needs to be larger than 0");
    assert(smoothness > 0, "max offset needs to be larger than 0");
    return 1 + pow((e), smoothness * (currentOffset - maxOffset)).toDouble();
  }

  @override
  void initState() {
    _gradient = AnimatedGradient(
      vsync: this,
      circlesCount: 30,
      medianRadius: 90,
      radiusChange: 0.25,
      // backgroundColor: Color(0xFF1a1230),
      // gradientColors: [HSLColor.fromAHSL(0.4, 272.89, 0.67, 0.39).toColor(), Colors.transparent,],
      backgroundColor: context.read<GameState>().currentPlayerColor.withLightness(0.2).toColor(),
      gradientColors: [context.read<GameState>().currentPlayerColor.toColor() ,Colors.transparent],

      child: Text(
        "?",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 110,
          color: Colors.white
        ),
      ),
    );
    super.initState();
  }
}

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return context.read<GameState>().currentIndex + 1 < context.read<GameState>().playerCount 
    ? FilledButton(
        onPressed: () => context.read<GameState>().incrementCurrentIndex(),
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