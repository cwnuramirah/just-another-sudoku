import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:just_another_sudoku/ui/expanded_text_button.dart';
import 'package:just_another_sudoku/ui/game/sudoku_page.dart';
import 'package:just_another_sudoku/ui/home/settings_page.dart';

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
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16.0),
                ExpandedTextButton(
                  icon: TablerIcons.adjustments_horizontal,
                  label: "Settings",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingsPage()),
                    );
                  },
                ),
                ExpandedTextButton(
                  icon: TablerIcons.chart_bar,
                  label: "Statistics",
                  onPressed: () {},
                ),
                const SizedBox(height: 16.0),
                ExpandedTextButton(
                  label: "New Game",
                  primary: true,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SudokuPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}