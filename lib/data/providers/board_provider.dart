import 'package:flutter/material.dart';
import 'package:just_another_sudoku/data/models/board_model.dart';
import 'package:just_another_sudoku/data/models/cell_model.dart';
import 'package:just_another_sudoku/data/models/move.dart';
import 'package:just_another_sudoku/data/providers/game_session_provider.dart';
import 'package:just_another_sudoku/logic/game_mode.dart';
import 'package:just_another_sudoku/logic/sudoku_error_handler.dart';

class BoardProvider with ChangeNotifier {
  late BoardModel _board;
  late GameSessionProvider _game;
  late GameMode _mode;

  bool isCompleted = false;
  int mistakeCount = 0;

  BoardProvider(
    GameMode? mode,
    List<List<CellModel>>? initialBoard,
    GameSessionProvider game,
  ) {
    _board = BoardModel(mode, initialBoard);
    _game = game;
    _mode = mode ?? GameMode.easy;
  }

  List<List<CellModel>> get board => _board.board;
  GameMode get mode => _mode;
  int get selectedValue => _board.selectedValue;
  int get selectedRow => _board.selectedRow;
  int get selectedColumn => _board.selectedColumn;
  bool get noteToggled => _board.noteToggled;
  bool get boardHidden => _board.isBoardHidden;

  void addBoardToGame() {
    if (_game.currentGame != null && _game.currentGame!.board == null) {
      _game.addBoard(_board);
    }
  }

  void checkIfCompleted() {
    int zeroCount =
        board.expand((row) => row).where((cell) => cell.value == 0).length;
    int errorCount =
        board.expand((row) => row).where((cell) => cell.isError).length;

    if (zeroCount == 0 && errorCount == 0) {
      isCompleted = true;
      _game.completeGame();
      notifyListeners();
    }
  }

  void toggleHide() {
    _board.isBoardHidden = !_board.isBoardHidden;
    notifyListeners();
  }

  void selectCell(int column, int row) {
    _board.selectedColumn = column;
    _board.selectedRow = row;
    _board.selectedValue = _board.board[column][row].value;
    notifyListeners();
  }

  void updateCell({int? col, int? row, required int value}) {
    int targetCol = col ?? _board.selectedColumn;
    int targetRow = row ?? _board.selectedRow;
    _board.selectedValue = value;

    if (value < 0 ||
        value > 9 ||
        _board.board[targetCol][targetRow].isFixed) return;

    _board.board[targetCol][targetRow].value = value;

    bool hasError = SudokuErrorHandler()
        .handleCellError(_board.board, targetCol, targetRow, value);

    if (hasError) {
      mistakeCount++;
	  _game.addMistakeCount();
    }

    notifyListeners();

    checkIfCompleted();
  }

  void toggleNote() {
    _board.noteToggled = !_board.noteToggled;
    notifyListeners();
  }

  void addNote(int number) {
    if (number < 1 || number > 9) return;

    CellModel cell =
        _board.board[_board.selectedColumn][_board.selectedRow];

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
    _board.board[_board.selectedColumn][_board.selectedRow].notes
        .clear();
    notifyListeners();
  }

  void addMove(int col, int row, int newValue) {
    _board.history.add(
      Move(
        column: col,
        row: row,
        prevValue: _board.board[col][row].value,
        newValue: newValue,
      ),
    );
    updateCell(value: newValue);
  }

  void undoMove() {
    if (_board.history.isEmpty) return;
    final latestMove = _board.history.removeLast();

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
        if (!_board.board[row][col].isFixed) {
          _board.board[row][col].value = 0;
        }
        _board.board[row][col].isError = false;
      }
    }
    _board.history.clear();
    _board.selectedValue = 0;
    _board.selectedRow = 0;
    _board.selectedColumn = 0;
    _board.noteToggled = false;

    notifyListeners();
  }
}
