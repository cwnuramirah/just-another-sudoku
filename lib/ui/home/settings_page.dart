import 'package:flutter/material.dart';
import 'package:just_another_sudoku/ui/common/chevron_back_button.dart';
import 'package:just_another_sudoku/ui/common/option_menu.dart';

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
        leading: const ChevronBackButton(),
      ),
      body: const OptionMenu(),
    );
  }
}
