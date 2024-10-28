import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:just_another_sudoku/data/providers/board_provider.dart';
import 'package:just_another_sudoku/data/providers/game_session_provider.dart';
import 'package:just_another_sudoku/logic/time_handler.dart';
import 'package:just_another_sudoku/ui/common/expanded_text_button.dart';
import 'package:just_another_sudoku/ui/game/settings_modal.dart';
import 'package:provider/provider.dart';

class TimerButton extends StatefulWidget {
  const TimerButton({super.key});

  @override
  State<TimerButton> createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final timeHandler = context.read<TimeHandler>();

        timeHandler.start();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      final timeHandler = context.read<TimeHandler>();
      final board = context.read<BoardProvider>();

      if (timeHandler.isRunning) {
        pauseDialog(context, timeHandler, board);
      }
    }
  }

  Future<void> pauseDialog(
      BuildContext context, TimeHandler time, BoardProvider board) {
    time.stop();
    board.toggleHide();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Paused!')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ExpandedTextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showSettingsModal(context, time, board);
                },
                icon: TablerIcons.adjustments_horizontal,
                label: 'Options',
              ),
              ExpandedTextButton(
                onPressed: () {
                  final gameSession = context.read<GameSessionProvider>();
                  gameSession.pauseGame();

                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                icon: TablerIcons.home,
                label: 'Return Home',
              ),
              ExpandedTextButton(
                onPressed: () {
                  final gameSession = context.read<GameSessionProvider>();
                  gameSession.resetGameTime();

                  board.resetBoard();
                  time.reset();
                  board.toggleHide();
                  time.start();
                  Navigator.of(context).pop();
                },
                icon: TablerIcons.reload,
                label: 'Restart',
              ),
              ExpandedTextButton(
                onPressed: () {
                  board.resetBoard();
                  board.toggleHide();
                  time.start();
                  Navigator.of(context).pop();
                },
                icon: TablerIcons.eraser,
                label: 'Reset Board',
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            ExpandedTextButton(
              onPressed: () {
                board.toggleHide();
                time.start();
                Navigator.of(context).pop();
              },
              icon: TablerIcons.player_play_filled,
              label: 'Resume',
              primary: true,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<TimeHandler, BoardProvider>(
      builder: (context, timeHandler, board, _) {

        return TextButton.icon(
          onPressed: () =>
              board.isCompleted ? {} : pauseDialog(context, timeHandler, board),
          style: TextButton.styleFrom(foregroundColor: Colors.black),
          icon: SizedBox(
            width: 20.0,
            height: 22.0,
            child: Icon(
              timeHandler.isRunning
                  ? TablerIcons.clock_pause
                  : TablerIcons.clock_play,
              size: 20.0,
            ),
          ),
          label: SizedBox(
            width: 56.0,
            child: Text(timeHandler.formatTime(),
                style: const TextStyle(height: 1.2, fontSize: 18.0)),
          ),
        );
      },
    );
  }
}
