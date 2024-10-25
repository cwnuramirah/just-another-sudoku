import 'package:flutter/material.dart';
import 'package:just_another_sudoku/data/providers/board_provider.dart';
import 'package:provider/provider.dart';

class Keypad extends StatelessWidget {
  const Keypad({super.key});

  @override
  Widget build(BuildContext context) {
    final board = Provider.of<BoardProvider>(context);
    final selectedRow =
        context.select<BoardProvider, int>((model) => model.selectedRow);
    final selectedColumn =
        context.select<BoardProvider, int>((model) => model.selectedColumn);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < 9; i++)
          SizedBox(
            width: 34.0,
            child: TextButton(
              onPressed: () {
                if (!board.board[selectedColumn][selectedRow].isFixed) {
                  if (!board.noteToggled) {
                    board.clearNotes();
                    board.addMove(selectedColumn, selectedRow, i+1);
                  } else {
                    board.addNote(i + 1);
                  }
                }
              },
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Text(
                "${i + 1}",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 36.0,
                  color: board.noteToggled ? Colors.grey.shade600 : Colors.black,
                ),
              ),
            ),
          )
      ],
    );
  }
}
