import 'package:flutter/material.dart';
import 'package:just_another_sudoku/data/models/board_model.dart';
import 'package:just_another_sudoku/data/models/cell_model.dart';
import 'package:provider/provider.dart';

class Cell extends StatelessWidget {
  const Cell({
    super.key,
    required this.board,
    required this.column,
    required this.row,
  });

  final List<List<CellModel>> board;
  final int column;
  final int row;

  @override
  Widget build(BuildContext context) {
    final boardModel = Provider.of<BoardModel>(context);
    final selectedRow =
        context.select<BoardModel, int>((model) => model.selectedRow);
    final selectedColumn =
        context.select<BoardModel, int>((model) => model.selectedColumn);

    CellModel currentCell = board[column][row];

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
        backgroundColor = Colors.blue.shade200;
      }

      // ERROR CELL
      if (currentCell.isError) {
        backgroundColor = Colors.red.shade100;
      }

      return backgroundColor;
    }

    Color getTextColor() {
      Color textColor = Colors.black;

      if (!currentCell.isFixed) {
        textColor = Colors.blue.shade700;
      }

      if (currentCell.isError && !currentCell.isFixed) {
        textColor = Colors.red;
      }

      return textColor;
    }

    return GestureDetector(
      onTap: () {
        boardModel.selectCell(column, row);
      },
      child: Container(
        margin: _boxMargin(column, row),
        decoration: BoxDecoration(
          border: _cellBorder(column, row),
          color: getBackgroundColor(),
        ),
        child: Center(
          child: Text(
            currentCell.value != 0 ? currentCell.value.toString() : '',
            style: TextStyle(fontSize: 22.0, color: getTextColor()),
          ),
        ),
      ),
    );
  }

  // served as 3x3 box border
  EdgeInsetsGeometry _boxMargin(int c, int r) {
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
