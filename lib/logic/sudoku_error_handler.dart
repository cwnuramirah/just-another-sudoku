import 'package:just_another_sudoku/data/models/cell_model.dart';

class SudokuErrorHandler {
  void handleCellError(
      List<List<CellModel>> board, int col, int row, int value) {
    _resetErrors(board, col, row);

    board[col][row].isError =
        value != 0 && _checkForErrors(board, col, row, value);
  }

  bool _checkForErrors(
      List<List<CellModel>> board, int col, int row, int value) {
    bool hasError = false;

    bool inRow = _hasDuplicateInRow(board, col, row, value);
    bool inColumn = _hasDuplicateInColumn(board, col, row, value);
    bool inBox = _hasDuplicateInBox(board, col, row, value);

    hasError = inRow || inColumn || inBox;
    return hasError;
  }

  void _resetErrors(List<List<CellModel>> board, int col, int row) {
    for (int i = 0; i < 9; i++) {
      _resetErrorForCell(board, col, i); // Reset row
      _resetErrorForCell(board, i, row); // Reset column
    }

    _iterateBox(board, col, row, (boxCol, boxRow) {
      _resetErrorForCell(board, boxCol, boxRow); // Reset 3x3 box
    });
  }

  void _resetErrorForCell(List<List<CellModel>> board, int col, int row) {
    var cell = board[col][row];
    if (cell.value != 0 && !_checkForErrors(board, col, row, cell.value)) {
      if (cell.isError) {
        cell.isError = false;
      }
    }
  }

  bool _hasDuplicateInRow(
      List<List<CellModel>> board, int col, int row, int value) {
    for (int i = 0; i < 9; i++) {
      if (i != row && board[col][i].value == value) {
        board[col][i].isError = true;
        return true;
      }
    }
    return false;
  }

  bool _hasDuplicateInColumn(
      List<List<CellModel>> board, int col, int row, int value) {
    for (int i = 0; i < 9; i++) {
      if (i != col && board[i][row].value == value) {
        board[i][row].isError = true;
        return true;
      }
    }
    return false;
  }

  bool _hasDuplicateInBox(
      List<List<CellModel>> board, int col, int row, int value) {
    bool hasError = false;
    _iterateBox(board, col, row, (boxCol, boxRow) {
      if ((boxCol != col || boxRow != row) &&
          board[boxCol][boxRow].value == value) {
        board[boxCol][boxRow].isError = true;
        hasError = true;
      }
    });
    return hasError;
  }

  void _iterateBox(List<List<CellModel>> board, int col, int row,
      void Function(int, int) action) {
    int boxColStart = (col ~/ 3) * 3;
    int boxRowStart = (row ~/ 3) * 3;
    for (int i = 0; i < 9; i++) {
      int boxCol = boxColStart + (i % 3);
      int boxRow = boxRowStart + (i ~/ 3);
      action(boxCol, boxRow);
    }
  }
}
