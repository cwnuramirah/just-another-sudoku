import 'package:flutter/material.dart';
import 'package:just_another_sudoku/data/providers/board_provider.dart';
import 'package:just_another_sudoku/data/providers/game_session_provider.dart';
import 'package:just_another_sudoku/logic/game_mode.dart';
import 'package:just_another_sudoku/ui/common/get_formatted_time.dart';
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
            color: !board.isCompleted
                ? Colors.black
                : Theme.of(context).colorScheme.secondary,
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
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Completed",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8.0),
                      DefaultTextStyle(
                        style: Theme.of(context).textTheme.titleMedium!,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("Mode:"),
                                Text("Time completed:"),
                                Text("Mistakes made:"),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(getGameModeText(board.mode)),
                                  Text(getFormattedTime(game.prevGames.last.duration)),
                                  Text(board.mistakeCount.toString()),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
