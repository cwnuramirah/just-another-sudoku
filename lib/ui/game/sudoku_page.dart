import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:just_another_sudoku/data/models/board_model.dart';
import 'package:just_another_sudoku/data/models/cell_model.dart';
import 'package:just_another_sudoku/logic/time_handler.dart';
import 'package:just_another_sudoku/ui/game/keypad.dart';
import 'package:just_another_sudoku/ui/option_menu.dart';
import 'package:just_another_sudoku/ui/game/sudoku_board.dart';
import 'package:just_another_sudoku/ui/game/timer.dart';
import 'package:just_another_sudoku/ui/game/toolbar.dart';
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
      child: Builder(builder: (context) {
        final timeHandler = context.read<TimeHandler>();
        final boardModel = context.read<BoardModel>();
        
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const TimerButton(),
            actions: [
              Builder(
                builder: (context) {
                  return Menu(onPressed: () {
                    Scaffold.of(context).openEndDrawer();

                    if (timeHandler.isRunning) {
                      timeHandler.stop();
                      boardModel.toggleHide();
                    }
                  });
                },
              ),
            ],
          ),
          onEndDrawerChanged: (isOpened) {
            if (!isOpened) {
              if (!timeHandler.isRunning) {
                timeHandler.start();
                boardModel.toggleHide();
              }
            }
          },
          endDrawer: const Drawer(child: SafeArea(child: OptionMenu())),
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
      }),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () {},
      icon: const SizedBox(
        height: 36,
        width: 36,
        child: Icon(TablerIcons.adjustments_horizontal),
      ),
    );
  }
}
