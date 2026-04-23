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
  double _containerOffset = 0.0;
  late final AnimatedGradient _gradient;
  // List<Tween<double>> _randomGradientAligment = [Tween(begin: 0.0, end: 1.0), Tween(begin: 0.0, end: 1.0)];

  
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
                _containerOffset = _containerOffset + details.delta.dy / sigmoid(smoothness, maxOffset, _containerOffset);  // TODO: make it not rebuild gradient every time container is moved
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
            child: _gradient,
          ),
        )
      ],
    );
  }

  double sigmoid(double smoothness, double maxOffset, double currentOffset) {
    return 1 + pow((e), smoothness * (currentOffset - maxOffset)).toDouble();
  }

  @override
  void initState() {
    _gradient = AnimatedGradient(this, circlesCount: 30,);
    super.initState();
  }
}



extension on Offset {
  Offset to(Offset b, double t) => Offset.lerp(this, b, t)!;
}
extension on Color? {
  Color? to(Color? b, double t) => Color.lerp(this, b, t);
}

class AnimatedGradient extends StatefulWidget {
  late final AnimationController _animationController;
  final int circlesCount;

  AnimatedGradient(TickerProvider vsync, {super.key, required this.circlesCount}) {
    _animationController =  AnimationController(vsync: vsync,
    duration: const Duration(seconds: 7),
    );
  }

  @override
  State<AnimatedGradient> createState() => _AnimatedGradientState();
}

class _AnimatedGradientState extends State<AnimatedGradient> {
  late List<Offset> lastCentersData;
  late List<Offset> newCentersData;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget._animationController,
      builder: (context, _)  {
        final double dt = widget._animationController.value;
        return CustomPaint(
          painter: _GradientPainter(
            centersData: List.generate(widget.circlesCount, (index) => lastCentersData[index].to(newCentersData[index], dt)),
            radiuses: List.generate(widget.circlesCount, (index) => 90),
          ),
        );
      }
    );
  }
  
  void _animationLoop() {
    widget._animationController.forward().then((_) {
      widget._animationController.reset();
      setState(() {
          lastCentersData = newCentersData;
          newCentersData = List.generate(widget.circlesCount, (index) => Offset(Random().nextDouble(), Random().nextDouble()));;
      });

      _animationLoop();
    });
  }

  @override
  void initState() {
    lastCentersData = List.generate(widget.circlesCount, (index) => Offset(Random().nextDouble(), Random().nextDouble()));
    newCentersData = List.generate(widget.circlesCount, (index) => Offset(Random().nextDouble(), Random().nextDouble()));
    _animationLoop();
    super.initState();
  }

  @override
  void dispose() {
    widget._animationController.dispose();
    super.dispose();
  }
}

class _GradientPainter extends CustomPainter {
  final List<Offset> centersData;
  final List<double> radiuses;

  const _GradientPainter({
    required this.centersData,
     required this.radiuses
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(30));

    canvas.drawRRect(rrect, Paint()..color = Color(0xFF1a1230));
    canvas.clipRRect(rrect);

    for(int i = 0; i < centersData.length; i++) {
      final paint = Paint()..shader = RadialGradient(
        colors: [
          Color(0xFF6b21a8).withAlpha(39),
          Colors.transparent,
          // Colors.white,
          // Colors.white
        ],
      ).createShader(Rect.fromCircle(center: offsetWithinBounds(centersData[i], size), radius: radiuses[i]));

      canvas.drawCircle(offsetWithinBounds(centersData[i], size), radiuses[i], paint);
    }
  }

  @override
  bool shouldRepaint(_GradientPainter old) => true; 

  Offset offsetWithinBounds(Offset offSet, Size rectSize) {
    return Offset(
      (offSet.dx * rectSize.width),
      (offSet.dy * rectSize.height)
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