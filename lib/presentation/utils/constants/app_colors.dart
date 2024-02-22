import 'package:flutter/material.dart';

class AppColors {
  static const Color lightGrey = Color(0xFFE0E0E0);
  static const Color backgroundGrey = Color(0xFFF2F2F2);
  static const Color brandColor = Color(0xFF2196F3);

  static Color getActiveDotColor(BuildContext context) {
    if (MediaQuery.of(context).platformBrightness == Brightness.light) {
      return const Color(0xff1f1f1f);
    } else {
      return Colors.amber.shade300;
    }
  }

  static Color getDotColor(BuildContext context) {
    if (MediaQuery.of(context).platformBrightness == Brightness.light) {
      return Colors.grey;
    } else {
      return Colors.white;
    }
  }

  static Color getChipBackgroundColor(BuildContext context) {
    if (MediaQuery.of(context).platformBrightness == Brightness.light) {
      return const Color.fromARGB(255, 233, 233, 233);
    } else {
      return const Color.fromARGB(255, 28, 28, 28);
    }
  }
}
