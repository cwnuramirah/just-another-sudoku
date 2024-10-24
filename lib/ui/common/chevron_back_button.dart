import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class ChevronBackButton extends StatelessWidget {
  const ChevronBackButton({super.key, this.onPressed});

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ??
          () {
            Navigator.of(context).pop();
          },
      icon: const SizedBox(
        height: 36,
        width: 36,
        child: Icon(
          TablerIcons.chevron_left,
        ),
      ),
    );
  }
}
