import 'package:flutter/material.dart';

class AppNavigator {
  static void push(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => page),
    );
  }

  static void pop(BuildContext context) {
    Navigator.pop(
      context,
    );
  }
}
