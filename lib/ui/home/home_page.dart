import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:just_another_sudoku/data/models/game_model.dart';
import 'package:just_another_sudoku/data/providers/game_session_provider.dart';
import 'package:just_another_sudoku/logic/game_mode.dart';
import 'package:just_another_sudoku/ui/common/expanded_text_button.dart';
import 'package:just_another_sudoku/ui/common/get_formatted_time.dart';
import 'package:just_another_sudoku/ui/game/sudoku_page.dart';
import 'package:just_another_sudoku/ui/common/new_game_button.dart';
import 'package:just_another_sudoku/ui/home/settings_page.dart';
import 'package:just_another_sudoku/ui/home/statistics_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "just another sudoku.",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16.0),
                ExpandedTextButton(
                  icon: TablerIcons.adjustments_horizontal,
                  label: "Settings",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPage()),
                    );
                  },
                ),
                ExpandedTextButton(
                  icon: TablerIcons.chart_bar,
                  label: "Statistics",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StatisticsPage()),
                    );
                  },
                ),
                const SizedBox(height: 16.0),
                buildResumeButton(context),
                const NewGameButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildResumeButton(BuildContext context) {
    final gameSession = context.watch<GameSessionProvider>();

    GameModel? onGoingGame = gameSession.currentGame;

    if (gameSession.isInitialized && onGoingGame != null) {
      return ExpandedTextButton(
        primary: true,
        label:
            "Resume (${getGameModeText(onGoingGame.mode)} : ${getFormattedTime(onGoingGame.duration)})",
        onPressed: () {
          gameSession.resumeGame();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SudokuPage(
                mode: onGoingGame.mode,
                initialBoard: onGoingGame.board,
                initialDuration: onGoingGame.duration,
              ),
            ),
          );
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}