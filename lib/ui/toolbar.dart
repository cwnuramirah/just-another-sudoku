import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:just_another_sudoku/data/models/board_model.dart';
import 'package:provider/provider.dart';

class Toolbar extends StatelessWidget {
  const Toolbar({super.key});

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
        CircleIconButtonWithBadge(
          onPressed: () {},
          icon: TablerIcons.bulb,
          badge: const Text('3'),
        ),
        CircleIconButton(
          onPressed: () {},
          icon: TablerIcons.arrow_back_up,
        ),
        CircleIconButton(
          onPressed: () {
            boardModel.updateCell(selectedColumn, selectedRow, 0);
          },
          icon: TablerIcons.eraser,
        ),
        CircleIconButtonWithBadge(
          onPressed: () {},
          icon: TablerIcons.pencil,
          badge: const Text('OFF'),
        ),
      ],
    );
  }
}

class CircleIconButtonWithBadge extends StatelessWidget {
  const CircleIconButtonWithBadge({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.badge,
  });

  final Function() onPressed;
  final IconData icon;
  final Widget badge;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        CircleIconButton(
          onPressed: onPressed,
          icon: icon,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 1.6),
              borderRadius: BorderRadius.circular(100)),
          margin: const EdgeInsets.only(left: 36.0),
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          child: DefaultTextStyle(
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),
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
  });

  final Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      alignment: Alignment.topCenter,
      // The icon somehow is not centered by default.
      icon: SizedBox(
        width: 48.0,
        height: 46.0,
        child: Icon(icon),
      ),
      style: IconButton.styleFrom(
        padding: const EdgeInsets.all(0.0),
        minimumSize: const Size(48.0, 48.0),
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.black, width: 1.6),
      ),
    );
  }
}
