import 'dart:math';

import 'package:flutter/material.dart';
import '../Colors.dart';

class DataRepository {
  static List<double> data = [];
  static List<String> labels = [];

  static List<double> getData() {
    return data;
  }

  static void clearData() {
    data = [];
  }

  static List<String> getLabels() {
    return labels;
  }

  static Color getColor() {
    List<Color> colors = [cyan, red, green, yellow];
    return colors[Random().nextInt(colors.length)];
  }

  static Color getDayColor(int day) {
    if (day < data.length) {
      return getColor();
    } else
      return Colors.indigo.shade50;
  }

  static Icon getIcon(int value) {
    if (value < 100) {
      return Icon(
        Icons.sentiment_very_satisfied_rounded,
        size: 24,
        color: getColor(),
      );
    } else if (value < 150) {
      return Icon(
        Icons.sentiment_very_satisfied_rounded,
        size: 24,
        color: getColor(),
      );
    } else
      return Icon(
        Icons.sentiment_very_satisfied_rounded,
        size: 24,
        color: getColor(),
      );
  }
}
