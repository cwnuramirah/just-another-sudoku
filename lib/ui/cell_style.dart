import 'package:flutter/material.dart';
import 'package:just_another_sudoku/data/models/cell_model.dart';

class CellStyle {
  final int column;
  final int row;
  final CellModel cell;
  final int selectedColumn;
  final int selectedRow;

  CellStyle({
    required this.column,
    required this.row,
    required this.cell,
    required this.selectedColumn,
    required this.selectedRow,
  });

  Color getBackgroundColor() {
    Color backgroundColor;
    bool isInSameColumn = column == selectedColumn;
    bool isInSameRow = row == selectedRow;
    bool isInSameBox = (column ~/ 3 == selectedColumn ~/ 3) &&
        (row ~/ 3 == selectedRow ~/ 3);

    if (isInSameColumn || isInSameRow || isInSameBox) {
      // HIGHLIGHT CELL
      backgroundColor = Colors.blue.shade50;
    } else {
      // IDLE CELL
      backgroundColor = Colors.white;
    }

    // SELECTED CELL
    if (column == selectedColumn && row == selectedRow) {
      backgroundColor = Colors.blue.shade200;
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
      textColor = Colors.blue.shade700;
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
