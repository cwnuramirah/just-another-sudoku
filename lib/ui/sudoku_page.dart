import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:just_another_sudoku/data/models/board_model.dart';
import 'package:just_another_sudoku/data/models/cell_model.dart';
import 'package:just_another_sudoku/logic/time_handler.dart';
import 'package:just_another_sudoku/ui/keypad.dart';
import 'package:just_another_sudoku/ui/sudoku_board.dart';
import 'package:just_another_sudoku/ui/timer.dart';
import 'package:just_another_sudoku/ui/toolbar.dart';
import 'package:provider/provider.dart';

class SudokuPage extends StatelessWidget {
  const SudokuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BoardModel()),
        ChangeNotifierProvider(create: (context) => CellModel()),
        ChangeNotifierProvider(create: (context) => TimeHandler()),
      ],
      
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const TimerButton(),
          actions: const [Menu()],
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
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const SizedBox(
        height: 36,
        width: 36,
        child: Icon(TablerIcons.adjustments_horizontal),
      ),
    );
  }
}
