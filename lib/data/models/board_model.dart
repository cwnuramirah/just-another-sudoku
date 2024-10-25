import 'package:just_another_sudoku/data/models/cell_model.dart';
import 'package:just_another_sudoku/logic/generator.dart';

  // final List<List<int>> _initBoard = [
  //   [0, 0, 3, 1, 2, 4, 0, 0, 7],
  //   [0, 0, 1, 6, 3, 9, 8, 4, 0],
  //   [9, 4, 6, 0, 8, 0, 0, 1, 3],
  //   [0, 2, 5, 3, 6, 1, 9, 0, 0],
  //   [4, 0, 0, 0, 9, 2, 3, 5, 0],
  //   [0, 6, 9, 4, 5, 0, 7, 2, 0],
  //   [6, 9, 0, 2, 0, 0, 0, 3, 0],
  //   [1, 0, 2, 8, 4, 0, 5, 0, 9],
  //   [8, 5, 0, 9, 1, 0, 4, 0, 0],
  // ];

  class BoardModel {
  late String mode;
  late List<List<CellModel>> board;
  late List<Move> history;

  int selectedValue = 0;
  int selectedRow = 0;
  int selectedColumn = 0;
  bool noteToggled = false;
  bool isBoardHidden = false;

  BoardModel(String? mode) {
    this.mode = mode ?? "Easy";
    board = _generateBoard();
    history = [];
  }

  List<List<CellModel>> _generateBoard() {
    List<List<int>> puzzle = [];

    switch (mode) {
      case "Easy":
        puzzle = generatePuzzle(minClues: 46);
        break;
      case "Normal":
        puzzle = generatePuzzle(minClues: 34);
        break;
      case "Hard":
        puzzle = generatePuzzle(minClues: 28);
        break;
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
