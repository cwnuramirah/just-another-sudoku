import 'package:flutter/material.dart';
import 'package:just_another_sudoku/data/models/board_model.dart';
import 'package:just_another_sudoku/data/models/cell_model.dart';
import 'package:just_another_sudoku/logic/sudoku_error_handler.dart';

class BoardProvider with ChangeNotifier {
  late BoardModel _boardModel;

  BoardProvider(String? mode) {
    _boardModel = BoardModel(mode);
  }

  List<List<CellModel>> get board => _boardModel.board;
  int get selectedValue => _boardModel.selectedValue;
  int get selectedRow => _boardModel.selectedRow;
  int get selectedColumn => _boardModel.selectedColumn;
  bool get noteToggled => _boardModel.noteToggled;
  bool get boardHidden => _boardModel.isBoardHidden;

  void toggleHide() {
    _boardModel.isBoardHidden = !_boardModel.isBoardHidden;
    notifyListeners();
  }

  void selectCell(int column, int row) {
    _boardModel.selectedColumn = column;
    _boardModel.selectedRow = row;
    _boardModel.selectedValue = _boardModel.board[column][row].value;
    notifyListeners();
  }

  void updateCell({int? col, int? row, required int value}) {
    int targetCol = col ?? _boardModel.selectedColumn;
    int targetRow = row ?? _boardModel.selectedRow;
    _boardModel.selectedValue = value;

    if (value < 0 || value > 9 || _boardModel.board[targetCol][targetRow].isFixed) return;

    _boardModel.board[targetCol][targetRow].value = value;
    SudokuErrorHandler().handleCellError(_boardModel.board, targetCol, targetRow, value);
    notifyListeners();
  }

  void toggleNote() {
    _boardModel.noteToggled = !_boardModel.noteToggled;
    notifyListeners();
  }

  void addNote(int number) {
    if (number < 1 || number > 9) return;

    CellModel cell = _boardModel.board[_boardModel.selectedColumn][_boardModel.selectedRow];

    if (cell.value != 0) {
      updateCell(value: 0);
    }

    if (cell.notes.contains(number)) {
      cell.notes.remove(number);
    } else {
      cell.notes.add(number);
    }

    notifyListeners();
  }

  void clearNotes() {
    _boardModel.board[_boardModel.selectedColumn][_boardModel.selectedRow].notes.clear();
    notifyListeners();
  }

  void addMove(int col, int row, int newValue) {
    _boardModel.history.add(
      Move(
        column: col,
        row: row,
        prevValue: _boardModel.board[col][row].value,
        newValue: newValue,
      ),
    );
    updateCell(value: newValue);
  }

  void undoMove() {
    if (_boardModel.history.isEmpty) return;
    final latestMove = _boardModel.history.removeLast();

    selectCell(latestMove.column, latestMove.row);
    updateCell(
      col: latestMove.column,
      row: latestMove.row,
      value: latestMove.prevValue,
    );
  }

  void resetBoard() {
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        if (!_boardModel.board[row][col].isFixed) {
          _boardModel.board[row][col].value = 0;
        }
        _boardModel.board[row][col].isError = false;
      }
    }
    _boardModel.history.clear();
    _boardModel.selectedValue = 0;
    _boardModel.selectedRow = 0;
    _boardModel.selectedColumn = 0;
    _boardModel.noteToggled = false;

    notifyListeners();
  }
}
