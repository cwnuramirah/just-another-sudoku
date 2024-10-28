import 'package:flutter/material.dart';
import 'package:just_another_sudoku/data/models/cell_model.dart';
import 'package:just_another_sudoku/data/providers/board_provider.dart';
import 'package:just_another_sudoku/data/providers/settings_provider.dart';
import 'package:just_another_sudoku/theme/cell_style.dart';
import 'package:provider/provider.dart';

class Cell extends StatelessWidget {
  const Cell({
    super.key,
    required this.column,
    required this.row,
  });

  final int column;
  final int row;

  @override
  Widget build(BuildContext context) {
    return Selector<BoardProvider, CellModel>(
        selector: (_, board) => board.board[column][row],
        builder: (_, cell, __) {
          final board = context.watch<BoardProvider>();
          final settings = context.read<SettingsProvider>();
          final selectedValue = board.selectedValue;
          final selectedRow = board.selectedRow;
          final selectedColumn = board.selectedColumn;
          final hide = board.boardHidden;

          CellStyle cellStyle = CellStyle(
            settings: settings,
            column: column,
            row: row,
            cell: cell,
            selectedValue: selectedValue,
            selectedColumn: selectedColumn,
            selectedRow: selectedRow,
          );

          return GestureDetector(
            key: key,
            onTap: () {
              board.selectCell(column, row);
            },
            child: Container(
              margin: cellStyle.getBoxMargin(),
              decoration: BoxDecoration(
                border: cellStyle.getGreyBorder(),
                color: !hide ? cellStyle.getBackgroundColor() : Colors.white,
              ),
              child: cell.notes.isEmpty
                  ? Center(
                      child: Text(
                        cell.value != 0 ? cell.value.toString() : '',
                        style: TextStyle(
                            fontSize: 22.0,
                            color: !hide
                                ? cellStyle.getTextColor()
                                : Colors.transparent),
                      ),
                    )
                  : Center(
                      child: GridView.count(
                        crossAxisCount: 3, // Display notes in a 3x3 grid
                        children: List.generate(9, (index) {
                          return Center(
                            child: Text(
                              cell.notes.contains(index + 1)
                                  ? '${index + 1}'
                                  : '',
                              style: TextStyle(
                                color:
                                    !hide ? Colors.black45 : Colors.transparent,
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
            ),
          );
        });
  }
}
