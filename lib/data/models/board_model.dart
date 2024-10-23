import 'package:flutter/foundation.dart';
import 'package:just_another_sudoku/data/models/cell_model.dart';
import 'package:just_another_sudoku/logic/generator.dart';
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

  late String _mode;
  late List<List<CellModel>> _board;
  late List<Move> _history;

  int _selectedValue = 0;
  int _selectedRow = 0;
  int _selectedColumn = 0;
  bool _noteToggled = false;
  bool _isBoardHidden = false;

  BoardModel(String? mode) {
    _mode = mode ?? "Easy";
    _board = _generateBoard();
    _history = [];
  }

  List<List<CellModel>> _generateBoard() {
    List<List<int>> puzzle = [];

    switch (_mode) {
      case "Easy" : puzzle = generatePuzzle(minClues: 46); // Easy: 36-40 clues
      case "Normal" : puzzle = generatePuzzle(minClues: 34);  // Normal: 30-35 clues
      case "Hard" : puzzle = generatePuzzle(minClues: 28);  // Hard: 25-29 clues
      default: puzzle = _initBoard;
    }

    return List.generate(
      9,
      (column) => List.generate(
        9,
        (row) => CellModel(
          value: puzzle[column][row],
          isFixed: puzzle[column][row] != 0,
        ),
      ),
    );
  }

  List<List<CellModel>> get board => _board;
  int get selectedValue => _selectedValue;
  int get selectedRow => _selectedRow;
  int get selectedColumn => _selectedColumn;
  bool get noteToggled => _noteToggled;
  bool get boardHidden => _isBoardHidden;

  void toggleHide() {
    _isBoardHidden = !_isBoardHidden;
    notifyListeners();
  }

  void selectCell(int column, int row) {
    _selectedColumn = column;
    _selectedRow = row;
    _selectedValue = _board[_selectedColumn][_selectedRow].value;
    notifyListeners();
  }

  void updateCell({int? col, int? row, required int value}) {
    int targetCol = col ?? _selectedColumn;
    int targetRow = row ?? _selectedRow;
    _selectedValue = value;

    // Ignore invalid values and skip for fixed cell
    if (value < 0 || value > 9 || _board[targetCol][targetRow].isFixed) return;

    _board[targetCol][targetRow].value = value;

    SudokuErrorHandler().handleCellError(_board, targetCol, targetRow, value);

    notifyListeners();
  }

  void toggleNote() {
    _noteToggled = !_noteToggled;
    notifyListeners();
  }

  void addNote(int number) {
    if (number < 1 || number > 9) return; // Ignore invalid values

    CellModel cell = _board[_selectedColumn][_selectedRow];

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
    _board[_selectedColumn][_selectedRow].notes.clear();
    notifyListeners();
  }

  void addMove(int col, int row, int newValue) {
    _history.add(
      Move(
        column: col,
        row: row,
        prevValue: _board[col][row].value,
        newValue: newValue,
      ),
    );
    updateCell(value: newValue);
  }

  void undoMove() {
    if (_history.isEmpty) return;
    final latestMove = _history.removeLast();

    selectCell(latestMove.column, latestMove.row);
    updateCell(
      col: latestMove.column,
      row: latestMove.row,
      value: latestMove.prevValue,
    );
  }

  // Reset the board to the initial state
  void resetBoard() {
    _board = _generateBoard();
    notifyListeners();
  }
}

class Move {
  int column;
  int row;
  int prevValue = 0;
  int newValue;

  Move({
    required this.column,
    required this.row,
    this.prevValue = 0,
    required this.newValue,
  });
}
