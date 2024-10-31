import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:just_another_sudoku/data/providers/board_provider.dart';
import 'package:provider/provider.dart';

class Toolbar extends StatelessWidget {
  const Toolbar({super.key});

  @override
  Widget build(BuildContext context) {
    final board = Provider.of<BoardProvider>(context);

    final screenWidth = MediaQuery.of(context).size.width;
	final btnSize = (screenWidth * 0.12).clamp(36.0, 46.0);

    return SizedBox(
      height: btnSize,
      width: screenWidth - 16.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleIconButtonWithBadge(
            onPressed: () {},
            icon: TablerIcons.bulb,
            badge: const Text('3'),
            btnSize: btnSize,
          ),
          CircleIconButton(
            onPressed: () {
              board.undoMove();
            },
            icon: TablerIcons.arrow_back_up,
            btnSize: btnSize,
          ),
          CircleIconButton(
            onPressed: () {
              board.addMove(board.selectedColumn, board.selectedRow, 0);
              board.clearNotes();
            },
            icon: TablerIcons.eraser,
            btnSize: btnSize,
          ),
          SizedBox(
            width: btnSize + 30,
            child: CircleIconButtonWithBadge(
              onPressed: () {
                board.toggleNote();
              },
              icon: TablerIcons.pencil,
              badge: Text(board.noteToggled ? 'ON' : 'OFF'),
              btnSize: btnSize,
            ),
          ),
        ],
      ),
    );
  }
}

class CircleIconButtonWithBadge extends StatelessWidget {
  const CircleIconButtonWithBadge({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.badge,
    required this.btnSize,
  });

  final Function() onPressed;
  final IconData icon;
  final Widget badge;
  final double btnSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        CircleIconButton(
          onPressed: onPressed,
          icon: icon,
          btnSize: btnSize,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 1.6),
              borderRadius: BorderRadius.circular(100)),
          margin: EdgeInsets.only(left: btnSize - 10),
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          child: DefaultTextStyle(
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 1.3,
                color: Colors.black),
            child: badge,
          ),
        )
      ],
    );
  }
}

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.btnSize,
  });

  final Function() onPressed;
  final IconData icon;
  final double btnSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: btnSize + 3.0,
        maxHeight: btnSize + 3.0,
      ),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: IconButton(
          onPressed: onPressed,
          alignment: Alignment.center,
          icon: Container(
            margin:
                const EdgeInsets.only(bottom: 4.0), // Offset for TablerIcons
            child: Icon(icon, size: btnSize * 0.55),
          ),
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.white,
            side: const BorderSide(color: Colors.black, width: 1.6),
          ),
        ),
      ),
    );
  }
}
