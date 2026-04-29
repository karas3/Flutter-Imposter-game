import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';


class AnimatedGradient extends StatefulWidget {
  late final AnimationController _animationController;

  final int circlesCount;
  final double medianRadius;
  final double? radiusChange;

  final Color? backgroundColor;
  final List<Color> gradientColors;

  final Widget? child;

  AnimatedGradient({super.key, required TickerProvider vsync,  required this.circlesCount, required this.medianRadius, this.radiusChange, required this.gradientColors, this.backgroundColor, this.child}) {
    _animationController =  AnimationController(vsync: vsync, duration: const Duration(seconds: 2),);
  }

  @override
  State<AnimatedGradient> createState() => _AnimatedGradientState();
}

class _AnimatedGradientState extends State<AnimatedGradient> {
  late final BlobList blobs;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget._animationController,
      builder: (context, _)  {
        final double dt = widget._animationController.value;
        return CustomPaint(
          painter: _GradientPainter(
            centersData: blobs.centerData(dt),
            radiuses: blobs.radiusesData(dt),
            backgroundColor: widget.backgroundColor,
            gradientColors: blobs.colors,
          ),
          child: widget.child,
        );
      }
    );
  }
  
  void _animationLoop() {
    widget._animationController.forward().then((_) {
      widget._animationController.reset();
      setState(() {
          blobs.randomizeData();
      });

      _animationLoop();
    });
  }

  @override
  void initState() {
    blobs = BlobList(
      circlesCount:  widget.circlesCount,
      medianRadius: widget.medianRadius,
      radiusChangePercentage: widget.radiusChange,
      gradientColors: widget.gradientColors,
    );
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

  final Color? backgroundColor;
  final List<Color> gradientColors;

  const _GradientPainter({
    required this.centersData,
    required this.radiuses,
    required this.gradientColors,
    this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(30));

    // canvas.drawRRect(rrect, Paint()..color = (backgroundColor ?? Colors.transparent)..imageFilter = ImageFilter.blur(sigmaX: 10, sigmaY: 10)); // with shadow
    canvas.clipRRect(rrect);
    canvas.drawRRect(rrect, Paint()..color = (backgroundColor ?? Colors.transparent)..imageFilter = ImageFilter.blur(sigmaX: 10, sigmaY: 10));

    for(int i = 0; i < centersData.length; i++) {
      final paint = Paint()..shader = RadialGradient(
        colors: gradientColors,
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


extension on Offset {
  Offset to(Offset b, double t) => Offset.lerp(this, b, t)!;
}
extension on double {
  double to(double b, double t) => lerpDouble(this, b, t)!;
}
class BlobList {
  late final int circlesCount;

  late List<Offset> _lastCentersData;
  late List<Offset> _newCentersData;

  late List<double> _lastRadiusesData;
  late List<double> _newRadiusesData;
  late final double medianRadius;
  late final double? radiusChangePercentage;
  late final double? radiusChange;

  late List<Color> gradientColors;

  BlobList({required this.circlesCount, required this.medianRadius, this.radiusChangePercentage, required this.gradientColors}) {
    assert(circlesCount >= 0, "Circle count must be larger or equal 0");
    assert(medianRadius >= 4, "medianRadius count must larger or equal to 4");
    assert(gradientColors.length >= 2, "gradientColors needs atleast 2 colors specified");
    if(radiusChangePercentage != null) {
      assert(radiusChangePercentage! >= 0.0 && radiusChangePercentage! <= 1.0, "radiusChangePercentage must be between 0.0 and 1.0");
      radiusChange = medianRadius * radiusChangePercentage!;  // convert percentages to pixels
      _lastRadiusesData = List.generate(circlesCount, (index) => medianRadius + Random().nextInt(radiusChange!.toInt()) - radiusChange! / 2);
      _newRadiusesData = List.generate(circlesCount, (index) => medianRadius + Random().nextInt(radiusChange!.toInt()) - radiusChange! / 2);
    }

    _lastCentersData = List.generate(circlesCount, (index) => Offset(Random().nextDouble(), Random().nextDouble()));
    _newCentersData = List.generate(circlesCount, (index) => Offset(Random().nextDouble(), Random().nextDouble()));
  }

  void randomizeData() {
    if(radiusChangePercentage != null) {
      _lastRadiusesData = _newRadiusesData;
      _newRadiusesData = List.generate(circlesCount, (index) => medianRadius + Random().nextInt(radiusChange!.toInt() * 2) - radiusChange!);
    }

    _lastCentersData = _newCentersData;
    _newCentersData = List.generate(circlesCount, (index) => Offset(Random().nextDouble(), Random().nextDouble()));
  }

  // ===============================   GETTERS  ===============================
  List<double> radiusesData(double dt) => radiusChangePercentage != null ? List.generate(circlesCount, (index) => _lastRadiusesData[index].to(_newRadiusesData[index], dt)) : List.generate(circlesCount, (index) => medianRadius);
  List<Offset> centerData(double dt) => List.generate(circlesCount, (index) => _lastCentersData[index].to(_newCentersData[index], dt));
  List<Color> get colors => gradientColors;
}