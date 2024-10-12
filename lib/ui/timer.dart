import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class Timer extends StatefulWidget {
  const Timer({super.key});

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: const SizedBox(
        width: 20.0,
        height: 22.0,
        child: Icon(TablerIcons.player_pause_filled, size: 20.0),
      ),
      label: const Text("02:14", style: TextStyle(height: 1.2, fontSize: 18.0)),
    );
  }
}
