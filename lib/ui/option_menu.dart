import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

class OptionMenu extends StatelessWidget {
  const OptionMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CupertinoListTile(
          title: Text("Theme"),
          subtitle: Text("Blue"),
          trailing: CupertinoListTileChevron(),
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
