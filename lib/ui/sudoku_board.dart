import 'package:flutter/material.dart';
import 'package:just_another_sudoku/data/models/board_model.dart';
import 'package:just_another_sudoku/ui/cell.dart';
import 'package:provider/provider.dart';

class SudokuBoard extends StatefulWidget {
  const SudokuBoard({super.key});

  @override
  State<SudokuBoard> createState() => _SudokuBoardState();
}

class _SudokuBoardState extends State<SudokuBoard> {

  @override
  Widget build(BuildContext context) {
      final board = Provider.of<BoardModel>(context).board;

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
          child: Column(
            children: [
              for (int col = 0; col < 9; col++)
                Expanded(
                  child: Row(
                    children: [
                      for (int row = 0; row < 9; row++)
                        Expanded(
                          child: Cell(
                            board: board,
                            column: col,
                            row: row,
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
