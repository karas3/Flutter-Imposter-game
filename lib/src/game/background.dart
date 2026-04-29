import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math.dart' show Vector2, Matrix2;
import 'package:vector_math/vector_math_lists.dart';

import 'package:imposter_party_game/src/ui_elements/app_theme.dart';
import 'package:imposter_party_game/src/game/game_object.dart';

class Background extends StatefulWidget {
  late final AnimationController _colorTransitionController;

  Background({super.key, required TickerProvider vsync}) {
    _colorTransitionController = AnimationController(vsync: vsync, duration: const Duration(milliseconds: 300))..forward();
  }

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  @override
  Widget build(BuildContext context) {
    context.watch<GameState>().incrementCurrentIndex;
    return AnimatedBuilder(
      animation: widget._colorTransitionController,
      builder: (context, _) { 
        final double dt = widget._colorTransitionController.value;
        return CustomPaint (
          painter: _BackgroundPainter(
            color: context.read<GameState>().oldPlayerColor.to(context.read<GameState>().currentPlayerColor, dt),
          ),
          child: const SizedBox.expand(), // expand background for entire page
        );
      }
    );
  }

  @override
  void dispose() {
    widget._colorTransitionController.dispose();
    super.dispose();
  }
}

class _BackgroundPainter extends CustomPainter {
  HSLColor color;
  late final HSLColor backgroundColor; 
  _BackgroundPainter({required this.color}) {
    backgroundColor = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final shadow = Paint()..color = Colors.black..maskFilter = MaskFilter.blur(BlurStyle.outer, 7.5);
    late final Paint paint;
    
    if(AppTheme.isLightTheme) {
      paint = Paint()..color = color.withLightness((-color.lightness + 0.15).abs()).toColor();
      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = backgroundColor.toColor());  //background
    } else {
      paint = Paint()..color = color.toColor();
      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = backgroundColor.withLightness((color.lightness - 0.15).abs()).toColor());  //background
    }

    final shapes = [
      // CustomRect(center: Vector2(size.width/2, size.height/2), size: Size(1000, 40), rotationAngle: pi/2),

      // CustomRect(center: Vector2(300, 650), size: Size(600, 40), rotationAngle: pi/1.7),
      // CustomRect(center: Vector2(size.width - 300, 650), size: Size(600, 40), rotationAngle: -pi/1.7),
      
      CustomRect(center: Vector2(50, 300), size: Size(700, 40), rotationAngle: -pi/2.5),
      CustomRect(center: Vector2(size.width - 50, 300), size: Size(700, 40), rotationAngle: pi/2.5),

      CustomRect(center: Vector2(45, 100), size: Size(500, 40), rotationAngle: -pi/2.5),
      CustomRect(center: Vector2(size.width - 45 , 100), size: Size(500, 40), rotationAngle: pi/2.5),

    ];

    for(CustomRect shape in shapes) {
      canvas.drawPath(shape.rectFromPath, paint);
      canvas.drawPath(shape.rectFromPath, shadow);
    }
  }


  @override
  bool shouldRepaint(_BackgroundPainter old) => false;
}


class CustomRect {
  late final Path rect;
  final Vector2 center;
  final Size size;
  final double? rotationAngle;

  CustomRect({required this.center, required this.size, this.rotationAngle}) {
    Vector2List vertexData = Vector2List(4);
    vertexData[0] = Vector2(center.x - size.width/2, center.y - size.height/2);
    vertexData[1] = Vector2(center.x + size.width/2, center.y - size.height/2);
    vertexData[2] = Vector2(center.x + size.width/2, center.y + size.height/2);
    vertexData[3] = Vector2(center.x - size.width/2, center.y + size.height/2);

    if(rotationAngle != null) {
      vertexData = _rotate(vertexData, rotationAngle!);
    } 
    rect = Path();
    rect.moveTo(vertexData[0].x, vertexData[0].y);
    for(int i = 1; i < vertexData.length; i++) {
      rect.lineTo(vertexData[i].x, vertexData[i].y);
    }
    rect.close();
  }

  Vector2List _rotate(Vector2List vertexData, double angle) {
    final matrix = Matrix2.rotation(angle);
    for(int i = 0; i < vertexData.length; i++) {
        vertexData[i] = matrix.transformed(vertexData[i] - center) + center;
    }
    return vertexData;
  }

  Path get rectFromPath => rect;
}


extension on HSLColor {
  HSLColor to(HSLColor b, double t) => HSLColor.fromColor(Color.lerp(toColor(), b.toColor(), t)!);  // change AHSL to Color so the color change doesn't go through all of the different hues
}