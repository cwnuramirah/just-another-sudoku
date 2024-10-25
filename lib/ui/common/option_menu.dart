import 'package:flutter/cupertino.dart';
import 'package:just_another_sudoku/data/models/color_theme.dart';
import 'package:just_another_sudoku/data/providers/settings_provider.dart';
import 'package:just_another_sudoku/ui/common/styled_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class OptionMenu extends StatelessWidget {
  const OptionMenu({super.key});

  String _getCurrentColorThemeName({required int colorIndex}) {
    switch (colorIndex) {
      case 0:
        return "Blue";
      case 1:
        return "Purple";
      case 2:
        return "Green";
      case 3:
        return "Yellow";
      default:
        return "Unknown";
    }
  }

  Widget _buildColorThemeSelector({
    required BuildContext context,
    required SettingsProvider settings,
  }) {
    final ColorTheme colorTheme = ColorTheme();
    final colors = colorTheme.colorList;

    return StyledListSection(
      context: context,
      children: [
        ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 24.0),
          shape: const Border(),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Color Theme",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                _getCurrentColorThemeName(colorIndex: settings.activeThemeIndex),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: settings.activeColorTheme.text),
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(colors.length, (i) {
                  return Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      color: colors[i][1],
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: i == settings.activeThemeIndex
                            ? colors[i][0]
                            : Colors.transparent,
                        width: 2.0,
                      ),
                    ),
                    child: IconButton(
                      icon: const SizedBox.shrink(),
                      highlightColor: colors[i][0],
                      onPressed: () =>
                          settings.changeColorTheme(i),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSwitchSetting({
    required BuildContext context,
    required String title,
    required bool value,
    required Function(bool) onChanged,
    bool enabled = true,
  }) {
    return StyledList(
      context: context,
      title: title,
      enabled: enabled,
      trailing: CupertinoSwitch(
        value: value,
        onChanged: enabled ? onChanged : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildColorThemeSelector(context: context, settings: settings),
        StyledListSection(
          context: context,
          children: [
            _buildSwitchSetting(
              context: context,
              title: "Highlight same number",
              value: settings.preferences.highlightSameNumbers,
              onChanged: settings.toggleHighlightSameNumbers,
            ),
          ],
        ),
        StyledListSection(
          context: context,
          children: [
            _buildSwitchSetting(
              context: context,
              title: "Highlight violation instantly",
              value: settings.preferences.highlightViolation,
              onChanged: (value) {
                settings.toggleHighlightViolation(value);
                if (!value) {
                  settings.toggleCompareWithSolution(false);
                }
              },
            ),
            _buildSwitchSetting(
              context: context,
              title: "Compare to final solution",
              value: settings.preferences.compareWithSolution,
              onChanged: settings.toggleCompareWithSolution,
              enabled: settings.preferences.highlightViolation,
            ),
          ],
        ),
      ],
    );
  }
}
