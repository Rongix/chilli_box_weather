import 'package:flutter/material.dart';

// Return one of foreground color variants dependent on contrast
Color calculateContrastColor(
    Color background, Color darkVariant, Color lightVariant) {
  return background.computeLuminance() > 0.5 ? darkVariant : lightVariant;
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
