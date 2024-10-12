import 'package:flutter/material.dart';
import 'package:just_another_sudoku/data/models/board_model.dart';
import 'package:just_another_sudoku/data/models/cell_model.dart';
import 'package:just_another_sudoku/ui/cell_style.dart';
import 'package:provider/provider.dart';

class Cell extends StatelessWidget {
  const Cell({
    super.key,
    required this.board,
    required this.column,
    required this.row,
  });

  final List<List<CellModel>> board;
  final int column;
  final int row;

  @override
  Widget build(BuildContext context) {
    CellModel currentCell = board[column][row];

    return Selector<BoardModel, CellModel>(
        selector: (_, boardModel) => boardModel.board[column][row],
        builder: (_, cellModel, __) {
          final boardModel = Provider.of<BoardModel>(context);
          final selectedRow = boardModel.selectedRow;
          final selectedColumn = boardModel.selectedColumn;

          CellStyle cellStyle = CellStyle(
            column: column,
            row: row,
            currentCell: currentCell,
            selectedColumn: selectedColumn,
            selectedRow: selectedRow,
          );

          return GestureDetector(
            onTap: () {
              boardModel.selectCell(column, row);
            },
            child: Container(
              margin: cellStyle.getBoxMargin(),
              decoration: BoxDecoration(
                border: cellStyle.getGreyBorder(),
                color: cellStyle.getBackgroundColor(),
              ),
              child: currentCell.notes.isEmpty
                  ? Center(
                      child: Text(
                        currentCell.value != 0
                            ? currentCell.value.toString()
                            : '',
                        style: TextStyle(
                            fontSize: 22.0, color: cellStyle.getTextColor()),
                      ),
                    )
                  : Center(
                      child: GridView.count(
                        crossAxisCount: 3,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          for (int i = 0; i < 9; i++)
                            Center(
                              child: Text(
                                '$i',
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 10.0),
                              ),
                            ),
                        ],
                      ),
                    ),
            ),
          );
        });
  }
}
