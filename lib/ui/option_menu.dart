import 'package:flutter/cupertino.dart';
import 'package:just_another_sudoku/data/models/color_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class OptionMenu extends StatelessWidget {
  const OptionMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final colorContext = context.watch<ColorTheme>();
    List<List<Color>> colors = colorContext.colorList;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: const Text("Color Theme"),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < colors.length; i++)
                Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                      color: colors[i][1],
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: i == colorContext.colorIndex
                            ? colors[i][0]
                            : Colors.transparent,
                        width: 2.0,
                      )),
                  child: IconButton(
                    icon: const SizedBox.shrink(),
                    highlightColor: colors[i][0],
                    onPressed: () {
                      colorContext.changeColorTheme(colors[i], i);
                    },
                  ),
                )
            ],
          ),
        ),
        CupertinoListTile(
          title: const Text("Highlight same number"),
          trailing: CupertinoSwitch(value: false, onChanged: (value) {}),
        ),
        CupertinoListTile(
          title: const Text("Highlight violation instantly"),
          trailing: CupertinoSwitch(value: true, onChanged: (value) {}),
        ),
        CupertinoListTile(
          title: const Text("Compare to final solution"),
          trailing: CupertinoSwitch(value: false, onChanged: (value) {}),
        ),
      ],
    );
  }
}
