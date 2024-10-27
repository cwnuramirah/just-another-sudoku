import 'package:just_another_sudoku/data/models/cell_model.dart';
import 'package:just_another_sudoku/data/models/move.dart';
import 'package:just_another_sudoku/logic/game_mode.dart';
import 'package:just_another_sudoku/logic/generator.dart';

class BoardModel {
  late GameMode mode;
  late List<List<CellModel>> board;
  late List<Move> history;

  int selectedValue = 0;
  int selectedRow = 0;
  int selectedColumn = 0;
  bool noteToggled = false;
  bool isBoardHidden = false;

  BoardModel(GameMode? mode, List<List<CellModel>>? initialBoard) {
    this.mode = mode ?? GameMode.easy;
    board = initialBoard ?? _generateBoard();
    history = [];
  }

  List<List<CellModel>> _generateBoard() {
    List<List<int>> puzzle = [];

    switch (mode) {
      case GameMode.easy:
        puzzle = generatePuzzle(minClues: 46);
        break;
      case GameMode.normal:
        puzzle = generatePuzzle(minClues: 34);
        break;
      case GameMode.hard:
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

  // Convert BoardModel to JSON
  Map<String, dynamic> toJson() => {
        'mode': mode.toString().split('.').last,
        'board': board
            .map((row) => row.map((cell) => cell.toJson()).toList())
            .toList(),
        'history': history.map((move) => move.toJson()).toList(),
        'selectedValue': selectedValue,
        'selectedRow': selectedRow,
        'selectedColumn': selectedColumn,
        'noteToggled': noteToggled,
        'isBoardHidden': isBoardHidden,
      };

  // Create BoardModel from JSON
  factory BoardModel.fromJson(Map<String, dynamic> json) {
    BoardModel boardModel = BoardModel(
        GameMode.values.firstWhere((e) => e.toString().split('.').last == json['mode']),
        (json['board'] as List)
            .map((row) =>
                (row as List).map((cell) => CellModel.fromJson(cell)).toList())
            .toList());
    boardModel.board = (json['board'] as List)
        .map((row) =>
            (row as List).map((cell) => CellModel.fromJson(cell)).toList())
        .toList();
    boardModel.history =
        (json['history'] as List).map((move) => Move.fromJson(move)).toList();
    boardModel.selectedValue = json['selectedValue'];
    boardModel.selectedRow = json['selectedRow'];
    boardModel.selectedColumn = json['selectedColumn'];
    boardModel.noteToggled = json['noteToggled'];
    boardModel.isBoardHidden = json['isBoardHidden'];
    return boardModel;
  }
}
