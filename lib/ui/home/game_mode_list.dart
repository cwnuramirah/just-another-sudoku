import 'package:flutter/material.dart';
import 'package:just_another_sudoku/ui/common/expanded_text_button.dart';
import 'package:just_another_sudoku/ui/game/sudoku_page.dart';

class GameModeList extends StatelessWidget {
  const GameModeList({super.key});

  // Helper method to build each button
  Widget _buildGameModeButton(BuildContext context, String mode) {
    return ExpandedTextButton(
      label: mode,
      onPressed: () {
        Navigator.pop(context); // Close the bottom sheet first
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
          _buildGameModeButton(context, "Easy"),
          _buildGameModeButton(context, "Normal"),
          _buildGameModeButton(context, "Hard"),
        ],
      ),
    );
  }
}
