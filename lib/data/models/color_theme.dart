import 'package:flutter/material.dart';
import 'package:just_another_sudoku/ui/color_contants.dart';

class ColorTheme with ChangeNotifier {
  late List<Color> _color;
  late int _colorIndex;

  ColorTheme({List<Color>? initialColor, int? colorIndex}) {
    _color = initialColor ?? ColorConstants.blue;
    _colorIndex = colorIndex ?? 0;
  }

  /// Use [ColorConstants]
  void changeColorTheme(List<Color> color, int colorIndex) {
    _color = color;
    _colorIndex = colorIndex;
    notifyListeners();
  }

  List<List<Color>> get colorList => [
        ColorConstants.blue,
        ColorConstants.green,
        ColorConstants.purple,
        ColorConstants.yellow,
      ];
  int get colorIndex => _colorIndex;
  List<Color> get colorSwatch => _color;
  Color get highlight => _color[2];
  Color get selected => _color[1];
  Color get text => _color[0];
}
