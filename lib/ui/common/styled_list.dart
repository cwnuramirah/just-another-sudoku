import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StyledListSection extends StatelessWidget {
  const StyledListSection({
    super.key,
    required this.context,
    required this.children,
    this.header,
  });

  final BuildContext context;
  final List<Widget> children;
  final String? header;

  @override
  Widget build(BuildContext context) {
    return CupertinoListSection.insetGrouped(
      header: header != null
          ? Text(
              header!,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w600),
            )
          : null,
      backgroundColor: Colors.grey.shade100,
      children: children,
    );
  }
}

class StyledList extends StatelessWidget {
  const StyledList({
    super.key,
    required this.context,
    this.icon,
    required this.title,
    this.leading,
    this.trailing,
    this.enabled = true,
  });

  final BuildContext context;
  final IconData? icon;
  final Widget? leading;
  final String title;
  final Widget? trailing;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile.notched(
      leading: leading ??
          (icon != null
              ? SizedBox(
                  height: 36,
                  width: 36,
                  child:
                      Icon(icon, color: Theme.of(context).colorScheme.primary),
                )
              : null),
      title: Text(
        title,
        style: enabled!
            ? Theme.of(context).textTheme.titleMedium
            : Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.grey),
      ),
      trailing: trailing,
    );
  }
}
