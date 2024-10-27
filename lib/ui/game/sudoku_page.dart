import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:just_another_sudoku/data/models/board_model.dart';
import 'package:just_another_sudoku/data/providers/board_provider.dart';
import 'package:just_another_sudoku/data/providers/game_session_provider.dart';
import 'package:just_another_sudoku/logic/game_mode.dart';
import 'package:just_another_sudoku/logic/time_handler.dart';
import 'package:just_another_sudoku/ui/common/chevron_back_button.dart';
import 'package:just_another_sudoku/ui/game/keypad.dart';
import 'package:just_another_sudoku/ui/game/settings_modal.dart';
import 'package:just_another_sudoku/ui/game/sudoku_board.dart';
import 'package:just_another_sudoku/ui/game/timer.dart';
import 'package:just_another_sudoku/ui/game/toolbar.dart';
import 'package:provider/provider.dart';

class SudokuPage extends StatefulWidget {
  const SudokuPage({
    Key? key,
    required this.mode,
    this.initialBoard,
    this.initialDuration = Duration.zero,
  }) : super(key: key);

  final GameMode mode;
  final BoardModel? initialBoard;
  final Duration initialDuration;

  @override
  State<SudokuPage> createState() => _SudokuPageState();
}

class _SudokuPageState extends State<SudokuPage> {
  @override
  Widget build(BuildContext context) {
    final gameSession = context.read<GameSessionProvider>();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => BoardProvider(
              widget.mode,
              widget.initialBoard?.board,
              gameSession,
            ),
          ),
          ChangeNotifierProvider(create: (context) => TimeHandler(widget.initialDuration)),
        ],
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const TimerButton(),
            leading: ChevronBackButton(
              onPressed: () {
                final gameSession = context.read<GameSessionProvider>();
                gameSession.pauseGame();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
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
        ));
  }
}

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    final timeHandler = context.read<TimeHandler>();
    final boardProvider = context.read<BoardProvider>();

    return IconButton(
      onPressed: () => showSettingsModal(context, timeHandler, boardProvider),
      icon: const SizedBox(
        height: 36,
        width: 36,
        child: Icon(TablerIcons.adjustments_horizontal),
      ),
    );
  }
}
