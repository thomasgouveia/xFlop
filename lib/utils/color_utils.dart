import 'package:flutter/material.dart';

class ColorUtils {
  /// Construct a color from a hex code string, of the format #RRGGBB.
  static Color fromHex(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
