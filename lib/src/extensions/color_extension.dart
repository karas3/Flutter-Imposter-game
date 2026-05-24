import 'package:flutter/material.dart';

extension ColorExtension on Color {
  Color adjust({double? alpha, double? hue, double? lightness, double? saturation}) {
    HSLColor hslColorFormat = HSLColor.fromColor(this);
    if(alpha != null) {
      assert(alpha >= 0 && alpha <= 1, "Alpha must be 0 >= alpha <= 1");
      hslColorFormat = hslColorFormat.withAlpha(alpha);
    }
    if(hue != null) {
      assert(hue >= 0 && hue <= 360, "Hue must be 0 >= hue <= 1");
      hslColorFormat = hslColorFormat.withHue(hue);
    }
    if(lightness != null) {
      assert(lightness >= 0 && lightness <= 1, "Lightness must be 0 >= Lightness <= 1");
      hslColorFormat = hslColorFormat.withAlpha(lightness);
    }
    if(saturation != null) {
      assert(saturation >= 0 && saturation <= 1, "Saturation must be 0 >= Saturation <= 1");
      hslColorFormat = hslColorFormat.withSaturation(saturation);
    }
    return hslColorFormat.toColor();
  }
}