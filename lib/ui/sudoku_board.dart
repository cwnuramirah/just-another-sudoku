import 'package:flutter/material.dart';
import 'package:just_another_sudoku/ui/cell.dart';

class SudokuBoard extends StatefulWidget {
  const SudokuBoard({super.key});

  @override
  State<SudokuBoard> createState() => _SudokuBoardState();
}

class _SudokuBoardState extends State<SudokuBoard> {
  List<List<int>> board = [
    [0, 0, 3, 1, 2, 4, 0, 0, 7],
    [0, 0, 1, 6, 3, 9, 8, 4, 0],
    [9, 4, 6, 0, 8, 0, 0, 1, 3],
    [0, 2, 5, 3, 6, 1, 9, 0, 0],
    [4, 0, 0, 0, 9, 2, 3, 5, 0],
    [0, 6, 9, 4, 5, 0, 7, 2, 0],
    [6, 9, 0, 2, 0, 0, 0, 3, 0],
    [1, 0, 2, 8, 4, 0, 5, 0, 9],
    [8, 5, 0, 9, 1, 0, 4, 0, 0],
  ];

  late int selectedColumn;
  late int selectedRow;

  @override
  void initState() {
    super.initState();
    selectedColumn = 0;
    selectedRow = 0;
  }

  @override
  Widget build(BuildContext context) {
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
                            selectedColumn: selectedColumn,
                            selectedRow: selectedRow,
                            onCellTap: (col, row) {
                              setState(() {
                                selectedColumn = col;
                                selectedRow = row;
                              });
                            },
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
