import 'package:flutter/material.dart';
import 'package:just_another_sudoku/data/providers/board_provider.dart';
import 'package:just_another_sudoku/data/providers/game_session_provider.dart';
import 'package:just_another_sudoku/ui/game/cell.dart';
import 'package:provider/provider.dart';

class SudokuBoard extends StatelessWidget {
  const SudokuBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameSessionProvider>();
    final board = context.watch<BoardProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (game.currentGame != null && game.currentGame!.board == null) {
        board.addBoardToGame();
      }
    });

    return AspectRatio(
      aspectRatio: 0.98,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(width: 1.6, color: Colors.black)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          clipBehavior: Clip.hardEdge,
          child: !board.isCompleted
              ? Column(
                  children: [
                    for (int col = 0; col < 9; col++)
                      Expanded(
                        child: Row(
                          children: [
                            for (int row = 0; row < 9; row++)
                              Expanded(
                                child: Cell(
                                  key: ValueKey('cell-$col-$row'),
                                  column: col,
                                  row: row,
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                )
              : const Center(
                  child: Text(
                    "Completed",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
        ),
      ),
    );
  }
}
