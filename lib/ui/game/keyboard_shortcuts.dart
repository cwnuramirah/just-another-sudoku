import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_another_sudoku/data/providers/board_provider.dart';

class KeyboardShortcuts extends StatelessWidget {
  const KeyboardShortcuts({
    super.key,
    required this.board,
    required this.focusNode,
    required this.child,
  });

  final BoardProvider board;
  final FocusNode focusNode;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    int col = board.selectedColumn;
    int row = board.selectedRow;

    void addMove(int input) {
      if (!board.board[board.selectedColumn][board.selectedRow].isFixed) {
        if (!board.noteToggled) {
          board.clearNotes();
          board.addMove(board.selectedColumn, board.selectedRow, input);
        } else {
          board.addNote(input);
        }
      }
    }

    void clear() {
      board.addMove(board.selectedColumn, board.selectedRow, 0);
      board.clearNotes();
    }

    void toggleNote() {
      board.toggleNote();
    }

    void undo() {
      board.undoMove();
    }

    void cellLeft() {
      if (row == 0) {
        board.selectCell(col, 8);
        return;
      }

      if (row >= 1 && row <= 8) {
        board.selectCell(col, row - 1);
        return;
      }
    }

    void cellRight() {
      if (row == 8) {
        board.selectCell(col, 0);
        return;
      }

      if (row >= 0 && row <= 7) {
        board.selectCell(col, row + 1);
        return;
      }
    }

    void cellUp() {
      if (col == 0) {
        board.selectCell(8, row);
        return;
      }

      if (col >= 1 && col <= 8) {
        board.selectCell(col - 1, row);
        return;
      }
    }

    void cellDown() {
      if (col == 8) {
        board.selectCell(0, row);
        return;
      }

      if (col >= 0 && col <= 7) {
        board.selectCell(col + 1, row);
        return;
      }
    }



    // Configure keyboard shortcuts with `CallbackShortcuts`
    return CallbackShortcuts(
      bindings: {
        // Map numeric keys 1-9 on the main keyboard
        for (int i = LogicalKeyboardKey.digit1.keyId;
            i <= LogicalKeyboardKey.digit9.keyId;
            i++)
          LogicalKeySet(LogicalKeyboardKey(i)): () =>
              addMove((i - LogicalKeyboardKey.digit1.keyId) + 1),

        // Map numeric keys 1-9 on the numpad
        for (int i = LogicalKeyboardKey.numpad1.keyId;
            i <= LogicalKeyboardKey.numpad9.keyId;
            i++)
          LogicalKeySet(LogicalKeyboardKey(i)): () =>
              addMove((i - LogicalKeyboardKey.numpad1.keyId) + 1),

        // Backspace and Delete keys to clear
        LogicalKeySet(LogicalKeyboardKey.backspace): clear,
        LogicalKeySet(LogicalKeyboardKey.delete): clear,

        // Ctrl + N to toggleNote
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyN):
            toggleNote,

        // Ctrl + Z to undo
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyZ):
            undo,

        // Arrow keys to select cell
        LogicalKeySet(LogicalKeyboardKey.arrowUp): cellUp,
        LogicalKeySet(LogicalKeyboardKey.arrowDown): cellDown,
        LogicalKeySet(LogicalKeyboardKey.arrowLeft): cellLeft,
        LogicalKeySet(LogicalKeyboardKey.arrowRight): cellRight,
      },
      child: Focus(
        focusNode: focusNode,
        child: child,
      ),
    );
  }
}
