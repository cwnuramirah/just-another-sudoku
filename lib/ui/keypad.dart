import 'package:flutter/material.dart';
import 'package:just_another_sudoku/data/models/board_model.dart';
import 'package:provider/provider.dart';

class Keypad extends StatelessWidget {
  const Keypad({super.key});

  @override
  Widget build(BuildContext context) {
    final boardModel = Provider.of<BoardModel>(context, listen: false);
    final selectedRow =
        context.select<BoardModel, int>((model) => model.selectedRow);
    final selectedColumn =
        context.select<BoardModel, int>((model) => model.selectedColumn);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < 9; i++)
          SizedBox(
            width: 34.0,
            child: TextButton(
              onPressed: () {
                if (!boardModel.board[selectedColumn][selectedRow].isFixed) {
                  if (!boardModel.noteToggled) {
                    boardModel.clearNotes();
                    boardModel.updateCell(i + 1);
                  } else {
                    boardModel.addNote(i + 1);
                  }
                }
              },
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Text(
                "${i + 1}",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 36.0,
                  color: Colors.black,
                ),
              ),
            ),
          )
      ],
    );
  }
}
