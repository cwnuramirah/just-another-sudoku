import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:just_another_sudoku/data/models/board_model.dart';
import 'package:provider/provider.dart';

class TimerButton extends StatefulWidget {
  const TimerButton({super.key});

  @override
  State<TimerButton> createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
  late Stopwatch stopwatch;
  late Timer t;

  void handleStart() {
    stopwatch.start();
  }

  void handleStop() {
    stopwatch.stop();
  }

  String returnFormattedText() {
    var secs = stopwatch.elapsed.inSeconds;

    String seconds = (secs % 60).toString().padLeft(2, "0");
    String minutes = (secs ~/ 60).toString().padLeft(2, "0");

    return "$minutes:$seconds";
  }

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();

    t = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });

    handleStart();
  }

  @override
  Widget build(BuildContext context) {
    final boardModel = Provider.of<BoardModel>(context, listen: false);

    Future<void> pauseDialog() {
      handleStop();

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
                  onPressed: () {},
                  icon: TablerIcons.home,
                  label: 'Return Home',
                ),
                ExpandedTextButton(
                  onPressed: () {},
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
                  handleStart();
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

    return TextButton.icon(
      onPressed: () => pauseDialog(),
      icon: SizedBox(
        width: 20.0,
        height: 22.0,
        child: Icon(
          stopwatch.isRunning
              ? TablerIcons.player_pause_filled
              : TablerIcons.player_play_filled,
          size: 20.0,
        ),
      ),
      label: SizedBox(
		width: 56.0,
        child: Text(returnFormattedText(),
            style: const TextStyle(height: 1.2, fontSize: 18.0)),
      ),
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
