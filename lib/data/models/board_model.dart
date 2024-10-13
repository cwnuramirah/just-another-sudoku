import 'package:flutter/foundation.dart';
import 'package:just_another_sudoku/data/models/cell_model.dart';
import 'package:just_another_sudoku/logic/sudoku_error_handler.dart';

class BoardModel with ChangeNotifier {
  final List<List<int>> _initBoard = [
    [0, 0, 3, 1, 2, 4, 0, 0, 7],
    [0, 0, 1, 6, 3, 9, 8, 4, 0],
    [9, 4, 6, 0, 8, 0, 0, 1, 3],
    [0, 2, 5, 3, 6, 1, 9, 0, 0],
    [4, 0, 0, 0, 9, 2, 3, 5, 0],
    [0, 6, 9, 4, 5, 0, 7, 2, 0],
    [6, 9, 0, 2, 0, 0, 0, 3, 0],
    [1, 0, 2, 8, 4, 0, 5, 0, 9],
    [8, 5, 0, 9, 1, 0, 4, 0, 0],
  ];

  late List<List<CellModel>> _board;
  int _selectedRow = 0;
  int _selectedColumn = 0;
  bool _noteToggled = false;
  bool _boardHidden = false;

  BoardModel() {
    _board = _generateBoard();
  }

  List<List<CellModel>> _generateBoard() {
    return List.generate(
      9,
      (column) => List.generate(
        9,
        (row) => CellModel(
            value: _initBoard[column][row],
            isFixed: _initBoard[column][row] != 0),
      ),
    );
  }

  List<List<CellModel>> get board => _board;

  int get selectedRow => _selectedRow;
  int get selectedColumn => _selectedColumn;
  bool get noteToggled => _noteToggled;
  bool get boardHidden => _boardHidden;

  void toggleHide() {
    _boardHidden = !_boardHidden;
    notifyListeners();
  }

  void selectCell(int column, int row) {
    _selectedRow = row;
    _selectedColumn = column;
    notifyListeners();
  }

  void updateCell(int value) {
    int col = _selectedColumn;
    int row = _selectedRow;

    if (value < 0 || value > 9) return; // Ignore invalid values
    if (!_board[col][row].isFixed) {
      _board[col][row].value = value;

      SudokuErrorHandler().handleCellError(_board, col, row, value);

      notifyListeners();
    }
  }

  void toggleNote() {
    _noteToggled = !_noteToggled;
    notifyListeners();
  }

  void addNote(int number) {
    if (number >= 1 && number <= 9) {
      if (_board[_selectedColumn][_selectedRow].value != 0) {
        updateCell(0);
      }
      if (_board[_selectedColumn][_selectedRow].notes.contains(number)) {
        removeNote(number);
      } else {
        _board[_selectedColumn][_selectedRow].notes.add(number);
      }
    }
    notifyListeners();
  }

  void removeNote(int number) {
    _board[_selectedColumn][_selectedRow].notes.remove(number);
    notifyListeners();
  }

  void clearNotes() {
    _board[_selectedColumn][_selectedRow].notes.clear();
    notifyListeners();
  }

  // Reset the board to the initial state
  void resetBoard() {
    _board = _generateBoard();
    notifyListeners();
  }
}
