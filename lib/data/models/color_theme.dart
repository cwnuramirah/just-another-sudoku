import 'package:flutter/material.dart';
import 'package:just_another_sudoku/theme/color_contants.dart';

class ColorTheme {
  List<Color> color;
  int colorIndex;

  ColorTheme({
    List<Color>? colors,
    int? colorIndex,
  })  : color = colors ?? ColorConstants.blue,
        colorIndex = colorIndex ?? 0;

  List<List<Color>> get colorList => [
        ColorConstants.blue,
        ColorConstants.purple,
        ColorConstants.green,
        ColorConstants.yellow,
      ];

  Color get highlight => color[3];
  Color get highlightSameNumber => color[2];
  Color get selected => color[1];
  Color get text => color[0];
}
