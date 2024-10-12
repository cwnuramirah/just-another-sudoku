import 'package:just_another_sudoku/data/models/cell_model.dart';

class SudokuErrorHandler {
  void handleCellError(List<List<CellModel>> board, int col, int row, int value) {
    _resetErrors(board, col, row);

    if (value != 0) {
      board[col][row].isError = _checkForErrors(board, col, row, value);
    } else {
      board[col][row].isError = false;
    }
  }

  bool _checkForErrors(List<List<CellModel>> board, int col, int row, int value) {
    bool hasError = false;

    for (int i = 0; i < 9; i++) {
      // Check row for duplicates
      if (i != row && board[col][i].value == value) {
        board[col][i].isError = true;
        hasError = true;
      }

      // Check column for duplicates
      if (i != col && board[i][row].value == value) {
        board[i][row].isError = true;
        hasError = true;
      }

      // Check 3x3 box for duplicates
      int boxColStart = (col ~/ 3) * 3;
      int boxRowStart = (row ~/ 3) * 3;
      int boxCol = boxColStart + (i % 3);
      int boxRow = boxRowStart + (i ~/ 3);

      if ((boxCol != col || boxRow != row) &&
          board[boxCol][boxRow].value == value) {
        board[boxCol][boxRow].isError = true;
        hasError = true;
      }
    }

    return hasError;
  }

  void _resetErrors(List<List<CellModel>> board, int col, int row) {
    for (int i = 0; i < 9; i++) {
      // Reset error for cells in the same row
      if (board[col][i].value != 0 &&
          !_hasErrors(board, col, i, board[col][i].value)) {
        board[col][i].isError = false;
      }

      // Reset error for cells in the same column
      if (board[i][row].value != 0 &&
          !_hasErrors(board, i, row, board[i][row].value)) {
        board[i][row].isError = false;
      }

      // Reset error for cells in the same 3x3 box
      int boxColStart = (col ~/ 3) * 3;
      int boxRowStart = (row ~/ 3) * 3;
      int boxCol = boxColStart + (i % 3);
      int boxRow = boxRowStart + (i ~/ 3);

      if (board[boxCol][boxRow].value != 0 &&
          !_hasErrors(board, boxCol, boxRow, board[boxCol][boxRow].value)) {
        board[boxCol][boxRow].isError = false;
      }
    }
  }

  bool _hasErrors(List<List<CellModel>> board, int col, int row, int value) {
    for (int i = 0; i < 9; i++) {
      // Check row
      if (i != row && board[col][i].value == value) return true;

      // Check column
      if (i != col && board[i][row].value == value) return true;

      // Check 3x3 box
      int boxColStart = (col ~/ 3) * 3;
      int boxRowStart = (row ~/ 3) * 3;
      int boxCol = boxColStart + (i % 3);
      int boxRow = boxRowStart + (i ~/ 3);
      if ((boxCol != col || boxRow != row) &&
          board[boxCol][boxRow].value == value) return true;
    }
    return false;
  }
}
