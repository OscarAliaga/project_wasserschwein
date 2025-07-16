import 'package:flutter/material.dart';

class ButtonColors {
  static Color student(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.teal.shade700
          : Colors.teal.shade300;

  static Color parent(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.deepOrange.shade700
          : Colors.orange.shade300;

  static Color teacher(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.indigo.shade700
          : Colors.indigo.shade300;

  static Color neutral(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.grey.shade800
          : Colors.grey.shade200;

  static Color info(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.blueGrey.shade700
          : Colors.blueGrey.shade200;

  static Color textOn(Color backgroundColor) {
    final brightness = ThemeData.estimateBrightnessForColor(backgroundColor);
    return brightness == Brightness.dark ? Colors.white : Colors.black87;
  }

  static Color subtitleOn(Color backgroundColor) {
    final base = textOn(backgroundColor);
    return base.withOpacity(0.7);
  }
}
