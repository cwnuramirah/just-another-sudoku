import 'package:flutter/material.dart';
import 'package:just_another_sudoku/data/models/cell_model.dart';
import 'package:just_another_sudoku/data/providers/board_provider.dart';
import 'package:just_another_sudoku/data/providers/settings_provider.dart';
import 'package:just_another_sudoku/theme/cell_style.dart';
import 'package:just_another_sudoku/ui/game/keyboard_shortcuts.dart';
import 'package:provider/provider.dart';

class Cell extends StatefulWidget {
  const Cell({
    super.key,
    required this.column,
    required this.row,
  });

  final int column;
  final int row;

  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> {
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<BoardProvider, CellModel>(
        selector: (_, board) => board.board[widget.column][widget.row],
        builder: (_, cell, __) {
          final board = context.watch<BoardProvider>();
          final settings = context.read<SettingsProvider>();
          final selectedValue = board.selectedValue;
          final selectedRow = board.selectedRow;
          final selectedColumn = board.selectedColumn;
          final hide = board.boardHidden;

          CellStyle cellStyle = CellStyle(
            settings: settings,
            column: widget.column,
            row: widget.row,
            cell: cell,
            selectedValue: selectedValue,
            selectedColumn: selectedColumn,
            selectedRow: selectedRow,
          );

          if (widget.column == selectedColumn && widget.row == selectedRow) {
            focusNode.requestFocus();
          }

          return GestureDetector(
            onTap: () {
              board.selectCell(widget.column, widget.row);
            },
            child: KeyboardShortcuts(
              focusNode: focusNode,
              board: board,
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
                                  color: !hide
                                      ? Colors.black45
                                      : Colors.transparent,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
              ),
            ),
          );
        });
  }
}
