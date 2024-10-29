import 'package:flutter/material.dart';
import 'package:just_another_sudoku/data/models/game_model.dart';
import 'package:just_another_sudoku/data/providers/game_session_provider.dart';
import 'package:just_another_sudoku/logic/game_mode.dart';
import 'package:just_another_sudoku/ui/common/expanded_text_button.dart';
import 'package:just_another_sudoku/ui/game/sudoku_page.dart';
import 'package:provider/provider.dart';

class GameModeList extends StatelessWidget {
  const GameModeList({super.key});

  // Helper method to build each button
  Widget _buildGameModeButton(BuildContext context, GameMode mode) {
    final gameSessionProvider = context.watch<GameSessionProvider>();

    return ExpandedTextButton(
      label: getGameModeText(mode),
      onPressed: () {
        Navigator.of(context).popUntil((route) => route.isFirst);
        
        final newGame = GameModel(
          gameStarted: DateTime.now(),
          mode: mode,
        );
        
        gameSessionProvider.startNewGame(newGame);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SudokuPage(mode: mode),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 48.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildGameModeButton(context, GameMode.easy),
          _buildGameModeButton(context, GameMode.normal),
          _buildGameModeButton(context, GameMode.hard),
        ],
      ),
    );
  }
}
