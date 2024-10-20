import 'package:flutter/material.dart';
import 'package:just_another_sudoku/data/models/cell_model.dart';
import 'package:just_another_sudoku/data/models/color_theme.dart';

class CellStyle {
  final ColorTheme color;
  final int column;
  final int row;
  final CellModel cell;
  final int selectedColumn;
  final int selectedRow;

  CellStyle({
    required this.color,
    required this.column,
    required this.row,
    required this.cell,
    required this.selectedColumn,
    required this.selectedRow,
  });

  Color getBackgroundColor() {
    Color backgroundColor = Colors.white;
    bool isInSameColumn = column == selectedColumn;
    bool isInSameRow = row == selectedRow;
    bool isInSameBox =
        (column ~/ 3 == selectedColumn ~/ 3) && (row ~/ 3 == selectedRow ~/ 3);

    // HIGHLIGHT CELL
    if (isInSameColumn || isInSameRow || isInSameBox) {
      backgroundColor = color.highlight;
    }

    // SELECTED CELL
    if (column == selectedColumn && row == selectedRow) {
      backgroundColor = color.selected;
    }

    // ERROR CELL
    if (cell.isError) {
      backgroundColor = Colors.red.shade100;
    }

    return backgroundColor;
  }

  Color getTextColor() {
    Color textColor = Colors.black;

    if (!cell.isFixed) {
      textColor = color.text;
    }

    if (cell.isError && !cell.isFixed) {
      textColor = Colors.red;
    }

    return textColor;
  }

  EdgeInsetsGeometry getBoxMargin() {
    double left = 0.0;
    double bottom = 0.0;

    if (column == 2 || column == 5) {
      bottom = 1.6;
    }

    if (row == 3 || row == 6) {
      left = 1.6;
    }

    return EdgeInsets.only(left: left, bottom: bottom);
  }

  BoxBorder getGreyBorder() {
    BorderSide borderSideGrey =
        BorderSide(color: Colors.grey.shade100, width: 1.0);

    BorderSide left = borderSideGrey;
    BorderSide bottom = borderSideGrey;

    if (column == 2 || column == 5 || column == 8) {
      bottom = BorderSide.none;
    }

    if (row == 0 || row == 3 || row == 6) {
      left = BorderSide.none;
    }

    return Border(left: left, bottom: bottom);
  }
}
