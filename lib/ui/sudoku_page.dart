import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:just_another_sudoku/ui/keypad.dart';
import 'package:just_another_sudoku/ui/sudoku_board.dart';
import 'package:just_another_sudoku/ui/timer.dart';
import 'package:just_another_sudoku/ui/toolbar.dart';

class SudokuPage extends StatelessWidget {
  const SudokuPage({super.key});

  @override
  Widget build(BuildContext context) {
    IconData icon = TablerIcons.adjustments_horizontal;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Timer(),
        actions: [Menu(icon: icon)],
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 24.0),
              SudokuBoard(),
              SizedBox(height: 24.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Toolbar(),
              ),
              SizedBox(height: 24.0),
              Keypad(),
              SizedBox(height: 36.0),
            ],
          ),
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: SizedBox(
        height: 36,
        width: 36,
        child: Icon(icon),
      ),
    );
  }
}
