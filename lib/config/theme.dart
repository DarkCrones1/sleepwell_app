import 'package:flutter/material.dart';

const List<Color> _colorThemes = [
  Colors.brown,
  Colors.blueAccent,
  Colors.red,
  Colors.yellow,
  Colors.orange,
  Colors.teal,
  Colors.purpleAccent,
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0});

  ThemeData getTheme() =>
      ThemeData(useMaterial3: true, colorSchemeSeed: _colorThemes[selectedColor]);
}
