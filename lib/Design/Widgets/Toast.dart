import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

toast(BuildContext context, String text, Color color) {
  Toast.show("$text", context,
      duration: 3,
      gravity: Toast.CENTER,
      backgroundColor: color);
}

toastBottom(BuildContext context, String text, Color color) {
  Toast.show("$text", context,
      duration: 3,
      gravity: Toast.BOTTOM,
      backgroundColor: color);
}

toastTop(BuildContext context, String text, Color color) {
  Toast.show("$text", context,
      duration: 3,
      gravity: Toast.TOP,
      backgroundColor: color);
}