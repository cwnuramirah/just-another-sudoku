import 'package:flutter/cupertino.dart';
import 'package:just_another_sudoku/data/models/color_theme.dart';
import 'package:just_another_sudoku/data/models/settings_model.dart';
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
    required ColorTheme colorContext,
  }) {
    final colors = colorContext.colorList;

    return CupertinoListSection.insetGrouped(
      backgroundColor: Colors.grey.shade100,
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
                _getCurrentColorThemeName(colorIndex: colorContext.colorIndex),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: colorContext.text),
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
                        color: i == colorContext.colorIndex
                            ? colors[i][0]
                            : Colors.transparent,
                        width: 2.0,
                      ),
                    ),
                    child: IconButton(
                      icon: const SizedBox.shrink(),
                      highlightColor: colors[i][0],
                      onPressed: () => colorContext.changeColorTheme(colors[i], i),
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
    return CupertinoListTile.notched(
      title: Text(
        title,
        style: enabled
            ? Theme.of(context).textTheme.titleMedium
            : Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey),
      ),
      trailing: CupertinoSwitch(
        value: value,
        onChanged: enabled ? onChanged : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorContext = context.watch<ColorTheme>();
    final settings = context.watch<SettingsModel>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildColorThemeSelector(context: context, colorContext: colorContext),

        CupertinoListSection.insetGrouped(
          backgroundColor: Colors.grey.shade100,
          children: [
            _buildSwitchSetting(
              context: context,
              title: "Highlight same number",
              value: settings.highlightSameNumber,
              onChanged: settings.switchHighlightSameNumber,
            ),
          ],
        ),

        CupertinoListSection.insetGrouped(
          backgroundColor: Colors.grey.shade100,
          children: [
            _buildSwitchSetting(
              context: context,
              title: "Highlight violation instantly",
              value: settings.highlightViolation,
              onChanged: (value) {
                settings.switchHighlightViolation(value);
                if (!value) {
                  settings.switchCompareToSolution(false);
                }
              },
            ),
            _buildSwitchSetting(
              context: context,
              title: "Compare to final solution",
              value: settings.compareToSolution,
              onChanged: settings.switchCompareToSolution,
              enabled: settings.highlightViolation,
            ),
          ],
        ),
      ],
    );
  }
}
