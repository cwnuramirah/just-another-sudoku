import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:just_another_sudoku/ui/common/chevron_back_button.dart';
import 'package:just_another_sudoku/ui/common/styled_list.dart';

/// GAMES
///  - games started
///  - games solved (games won)
///  - solved rate (win rate)
///  - average mistake per game
///  - solved with no mistakes in game (wins with no mistakes)
/// TIME
///  - best time
///  - average time

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
                  value: "13",
                ),
                _buildStatsList(
                  context: context,
                  icon: TablerIcons.crown,
                  title: "Games Wins",
                  value: "9",
                ),
                _buildStatsList(
                  context: context,
                  icon: TablerIcons.chart_line,
                  title: "Win Rate",
                  value: "70.0%",
                ),
                _buildStatsList(
                  context: context,
                  icon: TablerIcons.x,
                  title: "Average mistakes per game",
                  value: "4",
                ),
                _buildStatsList(
                  context: context,
                  icon: TablerIcons.checks,
                  title: "Win without mistake",
                  value: "5",
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
                  value: "4:59",
                ),
                _buildStatsList(
                  context: context,
                  icon: TablerIcons.stopwatch,
                  title: "Average Time",
                  value: "13:03",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
