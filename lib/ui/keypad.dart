import 'package:flutter/material.dart';

class Keypad extends StatelessWidget {
  const Keypad({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < 9; i++)
          SizedBox(
            width: 34.0,
            child: TextButton(
              onPressed: () {},
              style:TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Text(
                "${i + 1}",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 36.0,
                  color: Colors.black,
                ),
              ),
            ),
          )
      ],
    );
  }
}
