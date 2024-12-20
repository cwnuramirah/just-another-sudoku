import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_another_sudoku/theme/size_constants.dart';

class BodyStyle extends StatelessWidget {
  const BodyStyle({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    bool isNonMobilePlatform = defaultTargetPlatform != TargetPlatform.android && defaultTargetPlatform != TargetPlatform.iOS;

    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: isNonMobilePlatform ? minAppWidth : null,
            height: isNonMobilePlatform ? minAppHeight : null,
            child: Center(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
