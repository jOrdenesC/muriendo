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

  static Color getColor(double value) {
    if (value < 100) {
      return red;
    } else if (value < 150) {
      return cyan;
    } else
      return green;
  }

  static Color getDayColor(int day) {
    if (day < data.length) {
      return getColor(data[day]);
    } else
      return Colors.indigo.shade50;
  }

  static Icon getIcon(double value) {
    if (value < 100) {
      return Icon(
        Icons.sentiment_neutral_rounded,
        size: 24,
        color: getColor(value),
      );
    } else if (value < 150) {
      return Icon(
        Icons.sentiment_satisfied_alt_rounded,
        size: 24,
        color: getColor(value),
      );
    } else
      return Icon(
        Icons.sentiment_very_satisfied_rounded,
        size: 24,
        color: getColor(value),
      );
  }
}
