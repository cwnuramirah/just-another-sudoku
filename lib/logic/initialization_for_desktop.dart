import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_another_sudoku/theme/size_constants.dart';
import 'package:window_manager/window_manager.dart';

void initializationForDesktop() async {
    if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      minimumSize: minAppSize,
      size: initAppSize,
      title: "just another sudoku.",
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setMinimumSize(minAppSize);
      await windowManager.show();
      await windowManager.focus();
    });
  }
}