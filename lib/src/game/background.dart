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
  late final BackgroundColors colors;

  @override
  Widget build(BuildContext context) {
    context.watch<GameState>().incrementCurrentIndex;   // rebuil page when switching players
    colors.colorAssigment(context);

    context.read<GameState>().didAppThemeChange = true;
    return AnimatedBuilder(
      animation: widget._colorTransitionController,
      builder: (context, _) { 
        final double dt = widget._colorTransitionController.value;
        return CustomPaint (
          painter: _BackgroundPainter(
            backgroundColor: colors.backgroundColor(dt),
            midgroundColor: colors.midgroundColor(dt),
          ),
          child: const SizedBox.expand(), // expand background for entire page
        );
      }
    );
  }

  @override
  void initState() {
    colors = BackgroundColors(playerColor : context.read<GameState>().currentPlayerColor);
    super.initState();
  }
  
  @override
  void dispose() {
    widget._colorTransitionController.dispose();
    super.dispose();
  }
}


class _BackgroundPainter extends CustomPainter {
  Color backgroundColor;
  Color midgroundColor;
  _BackgroundPainter({required this.backgroundColor, required this.midgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    final shadow = Paint()..color = Colors.black..maskFilter = MaskFilter.blur(BlurStyle.outer, 7.5);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = backgroundColor);  //background

    final shapes = [
      CustomRect(center: Vector2(300, 650), size: Size(600, 40), rotationAngle: pi/1.7),
      CustomRect(center: Vector2(size.width - 300, 650), size: Size(600, 40), rotationAngle: -pi/1.7),
      
      CustomRect(center: Vector2(50, 300), size: Size(700, 40), rotationAngle: -pi/2.5),
      CustomRect(center: Vector2(size.width - 50, 300), size: Size(700, 40), rotationAngle: pi/2.5),

      CustomRect(center: Vector2(45, 100), size: Size(500, 40), rotationAngle: -pi/2.5),
      CustomRect(center: Vector2(size.width - 45 , 100), size: Size(500, 40), rotationAngle: pi/2.5),

    ];

    for(CustomRect shape in shapes) {
      canvas.drawPath(shape.rectFromPath, Paint()..color = midgroundColor);
      canvas.drawPath(shape.rectFromPath, shadow);
    }
  }

  @override
  bool shouldRepaint(_BackgroundPainter old) => false;
}

class BackgroundColors {
  HSLColor playerColor;
  late HSLColor _oldBackgroundColor;
  late HSLColor _currentbackgroundColorColor;
  late HSLColor _oldMidgroundColor;
  late HSLColor _currentMidgroundColor;

  BackgroundColors({required this.playerColor});

  void colorAssigment(BuildContext context) {
    if(context.read<GameState>().didAppThemeChange) { //theme change
      if(AppTheme.isThemeLight) { //change from dark to light
        _oldBackgroundColor = playerColor.withLightness(playerColor.lightness * 0.7);
        _currentbackgroundColorColor = playerColor;
      } else {  //change from light to dark
        _oldBackgroundColor = playerColor;
        _currentbackgroundColorColor = playerColor.withLightness(playerColor.lightness * 0.7);
      }
      _oldMidgroundColor = _currentbackgroundColorColor;
      _currentMidgroundColor = _oldBackgroundColor;
    } else {  // next playertk
      if(AppTheme.isThemeLight) { //light theme
        _oldBackgroundColor = playerColor.withLightness(playerColor.lightness * 0.7);
        playerColor = context.read<GameState>().currentPlayerColor;
        _currentbackgroundColorColor = playerColor;

        _oldMidgroundColor = playerColor;
        _currentMidgroundColor = playerColor.withLightness(playerColor.lightness * 0.7);
      } else {  //dark theme
        _oldBackgroundColor = playerColor;
        playerColor = context.read<GameState>().currentPlayerColor;
        _currentbackgroundColorColor = playerColor.withLightness(playerColor.lightness * 0.7);

        _oldMidgroundColor = playerColor.withLightness(playerColor.lightness * 0.7);
        _currentMidgroundColor = playerColor;
      }
    }
  }

  // ========================== GETTERS ==========================
  Color backgroundColor(double dt) => _oldBackgroundColor.to(_currentbackgroundColorColor, dt).toColor();
  Color midgroundColor(double dt) => _oldMidgroundColor.to(_currentMidgroundColor, dt).toColor();
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