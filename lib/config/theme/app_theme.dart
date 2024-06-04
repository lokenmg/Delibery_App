import 'package:flutter/material.dart';

const List<Color> _colorsTheme = [
  Colors.deepOrange,
  Colors.orange,
  Colors.amber,
  Colors.yellow,
];

class AppTheme {
  final int selectedTheme;

  AppTheme({this.selectedTheme = 0})
      : assert(selectedTheme >= 0 && selectedTheme < _colorsTheme.length,
            "selectedTheme must be a value between 0 and ${_colorsTheme.length - 1}");

  ThemeData theme() {
    return ThemeData(useMaterial3: true, colorSchemeSeed: _colorsTheme[1]);
  }
}
