import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  const Cell({
    super.key,
    required this.board,
    required this.column,
    required this.row,
    required this.selectedColumn,
    required this.selectedRow,
    required this.onCellTap,
  });

  final List<List<int>> board;
  final int column;
  final int row;
  final int selectedColumn;
  final int selectedRow;
  final Function(int, int) onCellTap;

  @override
  Widget build(BuildContext context) {
    bool isInSameColumn = column == selectedColumn;
    bool isInSameRow = row == selectedRow;
    bool isInSameBox =
        (column ~/ 3 == selectedColumn ~/ 3) && (row ~/ 3 == selectedRow ~/ 3);

    Color getBackgroundColor() {
      Color backgroundColor;
      if (isInSameColumn || isInSameRow || isInSameBox) {
        // HIGHLIGHT CELL
        backgroundColor = Colors.blue.shade50;
      } else {
        backgroundColor = Colors.white;
      }

      // SELECTED CELL
      if (column == selectedColumn && row == selectedRow) {
        return Colors.blue.shade200;
      }

      return backgroundColor;
    }

    return GestureDetector(
      onTap: () {
        onCellTap(column, row);
      },
      child: Container(
        margin: _boxMargin(column, row),
        decoration: BoxDecoration(
          border: _cellBorder(column, row),
          color: getBackgroundColor(),
        ),
        child: Center(
          child: Text(
            board[column][row] != 0 ? board[column][row].toString() : '',
            style: const TextStyle(fontSize: 22.0, color: Colors.black),
          ),
        ),
      ),
    );
  }

  // served as 3x3 box border
  _boxMargin(int c, int r) {
    double left = 0.0;
    double bottom = 0.0;

    if (c == 2 || c == 5) {
      bottom = 1.6;
    }

    if (r == 3 || r == 6) {
      left = 1.6;
    }

    return EdgeInsets.only(left: left, bottom: bottom);
  }

  // served as individual cell border
  BoxBorder _cellBorder(int c, int r) {
    BorderSide borderSideGrey =
        BorderSide(color: Colors.grey.shade100, width: 1.0);

    BorderSide left = borderSideGrey;
    BorderSide bottom = borderSideGrey;

    if (c == 2 || c == 5 || c == 8) {
      bottom = BorderSide.none;
    }

    if (r == 0 || r == 3 || r == 6) {
      left = BorderSide.none;
    }

    return Border(left: left, bottom: bottom);
  }
}
