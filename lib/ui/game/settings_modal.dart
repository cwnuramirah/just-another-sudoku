import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:just_another_sudoku/data/models/board_model.dart';
import 'package:just_another_sudoku/logic/time_handler.dart';
import 'package:just_another_sudoku/ui/common/option_menu.dart';

void showSettingsModal(BuildContext context, TimeHandler timeHandler, BoardModel boardModel) {
  showModalBottomSheet(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height - kToolbarHeight,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(TablerIcons.x),
            ),
            const OptionMenu(),
            const SizedBox(height: 36.0),
          ],
        ),
      );
    },
  ).whenComplete(() {
    if (!timeHandler.isRunning) {
      timeHandler.start();
      boardModel.toggleHide();
    }
  });

  if (timeHandler.isRunning) {
    timeHandler.stop();
    boardModel.toggleHide();
  }
}