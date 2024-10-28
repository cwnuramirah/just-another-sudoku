import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:just_another_sudoku/data/models/statistics_model.dart';
import 'package:just_another_sudoku/data/providers/game_session_provider.dart';
import 'package:just_another_sudoku/ui/common/chevron_back_button.dart';
import 'package:just_another_sudoku/ui/common/get_formatted_time.dart';
import 'package:just_another_sudoku/ui/common/styled_list.dart';
import 'package:provider/provider.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  Widget _buildStatsList({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
  }) {
    return StyledList(
      context: context,
      icon: icon,
      title: title,
      trailing: Text(
        value,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gameSessions = context.read<GameSessionProvider>();
    final StatisticsModel statistics = StatisticsModel(games: gameSessions.prevGames);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Statistics",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: const ChevronBackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StyledListSection(
              context: context,
              header: "Games",
              children: [
                _buildStatsList(
                  context: context,
                  icon: TablerIcons.grid_3x3,
                  title: "Games Started",
                  value: statistics.games.isEmpty ? "-" : "${statistics.gamesStarted}",
                ),
                _buildStatsList(
                  context: context,
                  icon: TablerIcons.crown,
                  title: "Games Completed",
                  value: (statistics.games.isEmpty && (statistics.gamesStarted == 0)) ? "-" : "${statistics.completedGamesCount}",
                ),
                _buildStatsList(
                  context: context,
                  icon: TablerIcons.chart_line,
                  title: "Complete Rate",
                  value: statistics.games.isEmpty ? "-" : statistics.completedRate,
                ),
                _buildStatsList(
                  context: context,
                  icon: TablerIcons.flag_x,
                  title: "Average mistakes per game",
                  value: statistics.games.isEmpty ? "-" : "${statistics.averageMistakesPerGame}",
                ),
                _buildStatsList(
                  context: context,
                  icon: TablerIcons.flag_check,
                  title: "Win without mistake",
                  value: statistics.games.isEmpty ? "-" : "${statistics.completedGamesWithoutMistake}",
                ),
              ],
            ),
            StyledListSection(
              context: context,
              header: "Time",
              children: [
                _buildStatsList(
                  context: context,
                  icon: TablerIcons.thumb_up,
                  title: "Best Time",
                  value: statistics.games.isEmpty ? "-" : getFormattedTime(statistics.bestTime),
                ),
                _buildStatsList(
                  context: context,
                  icon: TablerIcons.stopwatch,
                  title: "Average Time",
                  value: statistics.games.isEmpty ? "-" : getFormattedTime(statistics.averageTime),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
