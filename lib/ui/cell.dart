import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  const Cell({
    super.key,
    required this.board,
    required this.column,
    required this.row,
  });

  final List<List<int>> board;
  final int column;
  final int row;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: _styleBorder(column, row),
      ),
      child: Center(
        child: Text(
          board[column][row].toString(),
          style: const TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  BoxBorder _styleBorder(int c, int r) {
    BorderSide borderSideBlack =
        const BorderSide(color: Colors.black, width: 1.6);
    BorderSide borderSideGrey =
        BorderSide(color: Colors.grey.shade100, width: 1.0);

    BorderSide left = borderSideGrey;
    BorderSide bottom = borderSideGrey;

    if (c == 2 || c == 5) {
      bottom = borderSideBlack;
    }

    if (r == 3 || r == 6) {
      left = borderSideBlack;
    }

    if (c == 8) {
      bottom = BorderSide.none;
    }

    if (r == 0) {
      left = BorderSide.none;
    }

    return Border(left: left, bottom: bottom);
  }
}
