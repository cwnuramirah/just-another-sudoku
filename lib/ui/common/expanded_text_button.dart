import 'package:flutter/material.dart';

class ExpandedTextButton extends StatelessWidget {
  const ExpandedTextButton({
    super.key,
    this.icon,
    required this.label,
    required this.onPressed,
    this.primary = false,
  });

  final IconData? icon;
  final String label;
  final Function() onPressed;
  final bool? primary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: primary! ? 12.0 : 8.0),
      child: SizedBox(
        width: double.infinity,
        child: TextButton.icon(
          style: primary!
              ? OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.black, width: 1.6),
                )
              : TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  backgroundColor: Colors.black.withOpacity(0.05),
                  foregroundColor: Colors.black,
                ),
          onPressed: onPressed,
          icon: SizedBox(
            height: 20,
            child: icon != null
                ? Icon(
                    icon,
                    size: 18,
                  )
                : null,
          ),
          label: Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
