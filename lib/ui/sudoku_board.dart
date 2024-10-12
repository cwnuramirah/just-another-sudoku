import 'package:flutter/material.dart';
import 'package:just_another_sudoku/ui/cell.dart';

class SudokuBoard extends StatelessWidget {
  const SudokuBoard({super.key});

  @override
  Widget build(BuildContext context) {
    List<List<int>> board =
        List.generate(9, (index) => List.generate(9, (index) => 1));

    return AspectRatio(
      aspectRatio: 0.98,
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1.6, color: Colors.black),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
			child: Column(
			  children: [
				for (int c = 0; c < 9; c++)
				  Expanded(
					child: Row(
					  children: [
						for (int r = 0; r < 9; r++)
						  Expanded(
							child: Cell(board: board, column: c, row: r)
						  )
					  ],
					),
				  )
			  ],
			),
		  )),
    );
  }
  
}
