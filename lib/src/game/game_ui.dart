import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_state_object.dart';
import 'package:imposter_party_game/src/ui_elements/custom_text.dart';
import 'package:imposter_party_game/src/extensions/color_extension.dart';
import 'custom_gradient_background.dart';

class NameDisplay extends StatelessWidget {
  final String name;
  final HSLColor backgroundColor;
  const NameDisplay({super.key, required this.name, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Text(
        name,
        style: AppTextStyles.gamePageHeaderText(backgroundColor),
        textAlign: TextAlign.center,
      ),
    );
  }
}


class TextBox extends StatefulWidget {
  const TextBox({super.key});

  @override
  State<TextBox> createState() => _TextBoxState();
}
class _TextBoxState extends State<TextBox> with SingleTickerProviderStateMixin {
  final double overlayHeight = 150;
  double _containerOffset = 0.0;  // offset of overlay box
  late final AnimatedGradientBackground _gradient;
  
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -overlayHeight / 2),
      child: Stack(
        alignment: AlignmentGeometry.center,  //aligns box to center
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,  //aligns text to center
            children: [
              Text(
                context.read<GameState>().isImposter ? "You're an imposter" : "You are a civilian",
                style: AppTextStyles.gamePageText(context.read<GameState>().currentPlayerColor),
                textAlign: TextAlign.center,
              ),
              Text(
                context.read<GameState>().isImposter ? "Your hint is:" : "Your word is:",
                style: AppTextStyles.gamePageText(context.read<GameState>().currentPlayerColor),
                textAlign: TextAlign.center,
              ),
              Text(
                context.read<GameState>().isImposter ? context.read<GameState>().hint : context.read<GameState>().word,
                style: AppTextStyles.gamePageText(context.read<GameState>().currentPlayerColor),
                textAlign: TextAlign.center,
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
              context.read<NextPlayerButtonState>().enable();
              setState(() => _containerOffset = 0);
            },
            child: Container(
              width: 300,
              height: overlayHeight,
              transform: Matrix4.translationValues(0, _containerOffset, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                boxShadow: [BoxShadow(color: Colors.black.withAlpha(255), blurRadius: 10.0, offset: Offset(5, 5))],
              ),
              child: _gradient,
            ),
          )
        ],
      ),
    );
  }

  double sigmoid(double smoothness, double maxOffset, double currentOffset) {
    assert(maxOffset > 0, "max offset needs to be larger than 0");
    assert(smoothness > 0, "max offset needs to be larger than 0");
    return 1 + pow((e), smoothness * (currentOffset - maxOffset)).toDouble();
  }

  @override
  void initState() {
    final HSLColor color = context.read<GameState>().currentPlayerColor;
    _gradient = AnimatedGradientBackground(
      vsync: this,
      circlesCount: 30,
      medianRadius: 90,
      radiusChange: 0.25,
      backgroundColor: color.withLightness(color.lightness.clamp(0.1, 0.3)).toColor(),
      gradientColors: [color.withLightness(color.lightness.clamp(0.3, 1)).toColor() ,Colors.transparent],
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
    final Color backgroundColor = Theme.of(context).colorScheme.primary;
    final ButtonStyle buttonStyle = ButtonStyle(
      backgroundColor: context.read<NextPlayerButtonState>().isEnabled
        ? WidgetStatePropertyAll(backgroundColor)  //enabled button
        : WidgetStatePropertyAll(backgroundColor.adjust(alpha: 0.3, saturation: 0)), //disabled button
    );
    final TextStyle textStyle = AppTextStyles.gamePageNextButton(context, context.read<NextPlayerButtonState>().isEnabled);
    return Container(
      margin: EdgeInsets.only(bottom: 100),
      key: ValueKey(context.watch<NextPlayerButtonState>().enable),
      child: Builder(builder: (context) => context.read<GameState>().isPlayerLast
        ? FilledButton(
            style: buttonStyle,
            onPressed: () {
              if(context.read<NextPlayerButtonState>().isEnabled) {
                context.read<GameState>().incrementCurrentIndex();
                context.read<NextPlayerButtonState>().disable();  // make button incactive for next player
              }
            },
            child: Text(
              "Next player",
              style: textStyle,
            ),
          )
        : FilledButton(
          style: buttonStyle,
          onPressed: () => {
            if(context.read<NextPlayerButtonState>().isEnabled) {}
          },
          child: Text(
            "Start",
            style: textStyle
          ),
        )
      ),
    );
  }
}