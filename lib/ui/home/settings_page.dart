import 'package:flutter/material.dart';
import 'package:just_another_sudoku/ui/option_menu.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: const OptionMenu(),
    );
  }
}
