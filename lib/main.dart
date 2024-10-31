import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_another_sudoku/data/providers/game_session_provider.dart';
import 'package:just_another_sudoku/data/providers/settings_provider.dart';
import 'package:just_another_sudoku/theme/size_constants.dart';
import 'package:just_another_sudoku/ui/home/home_page.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  if (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS) {
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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ChangeNotifierProvider(create: (context) => GameSessionProvider()),
      ],
      child: Consumer<SettingsProvider>(builder: (context, settings, _) {
        return MaterialApp(
          title: 'just another sudoku',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'WorkSans',
            useMaterial3: true,
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: <TargetPlatform, PageTransitionsBuilder>{
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              },
            ),
            colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: settings.activeColorTheme.color[0],
              onPrimary: Colors.white,
              secondary: settings.activeColorTheme.color[2],
              onSecondary: settings.activeColorTheme.color[0],
              surfaceTint: Colors.white,
              error: Colors.red,
              onError: Colors.white,
              background: Colors.grey.shade100,
              onBackground: Colors.black,
              surface: Colors.grey.shade100,
              onSurface: Colors.black,
            ),
          ),
          home: const HomePage(),
        );
      }),
    );
  }
}
