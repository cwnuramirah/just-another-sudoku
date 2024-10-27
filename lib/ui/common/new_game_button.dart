import 'package:flutter/material.dart';
import 'package:just_another_sudoku/ui/common/expanded_text_button.dart';
import 'package:just_another_sudoku/ui/common/game_mode_list.dart';

class NewGameButton extends StatelessWidget {
  const NewGameButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandedTextButton(
      primary: true,
      label: "New Game",
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => const GameModeList());
      },
    );
  }
}
