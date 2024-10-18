import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:just_another_sudoku/data/models/board_model.dart';
import 'package:just_another_sudoku/logic/time_handler.dart';
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
      final timeHandler = Provider.of<TimeHandler>(context, listen: false);
      timeHandler.start(); // Start the timer when dependencies are set up
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      final timeHandler = Provider.of<TimeHandler>(context, listen: false);
      final boardModel = Provider.of<BoardModel>(context, listen: false);
      if (timeHandler.isRunning) {
        pauseDialog(context, timeHandler, boardModel);
      }
    }
  }

  Future<void> pauseDialog(
      BuildContext context, TimeHandler time, BoardModel boardModel) {
    time.stop();
    boardModel.toggleHide();

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
                onPressed: () {},
                icon: TablerIcons.adjustments_horizontal,
                label: 'Options',
              ),
              ExpandedTextButton(
                onPressed: () {
                  boardModel.resetBoard();
                  time.reset();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                icon: TablerIcons.home,
                label: 'Return Home',
              ),
              ExpandedTextButton(
                onPressed: () {
                  boardModel.resetBoard();
                  time.reset();
                  boardModel.toggleHide();
                  time.start();
                  Navigator.of(context).pop();
                },
                icon: TablerIcons.reload,
                label: 'Restart',
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            ExpandedTextButton(
              onPressed: () {
                boardModel.toggleHide();
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
    final boardModel = Provider.of<BoardModel>(context, listen: false);

    return Consumer<TimeHandler>(
      builder: (context, time, _) {
        return TextButton.icon(
          onPressed: () => pauseDialog(context, time, boardModel),
          icon: SizedBox(
            width: 20.0,
            height: 22.0,
            child: Icon(
              time.isRunning
                  ? TablerIcons.player_pause_filled
                  : TablerIcons.player_play_filled,
              size: 20.0,
            ),
          ),
          label: SizedBox(
            width: 56.0,
            child: Text(time.getFormattedTime(),
                style: const TextStyle(height: 1.2, fontSize: 18.0)),
          ),
        );
      },
    );
  }
}

class ExpandedTextButton extends StatelessWidget {
  const ExpandedTextButton({
    super.key,
    this.icon,
    required this.label,
    required this.onPressed,
    this.primary = false,
  });

  final IconData? icon;
  final String label;
  final Function() onPressed;
  final bool? primary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: primary! ? 12.0 : 8.0),
      child: SizedBox(
        width: double.infinity,
        child: TextButton.icon(
          style: primary!
              ? OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.black, width: 1.6),
                )
              : TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  backgroundColor: Colors.black.withOpacity(0.05),
                  foregroundColor: Colors.black,
                ),
          onPressed: onPressed,
          icon: SizedBox(
            height: 20,
            child: icon != null
                ? Icon(
                    icon,
                    size: 18,
                  )
                : null,
          ),
          label: Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
