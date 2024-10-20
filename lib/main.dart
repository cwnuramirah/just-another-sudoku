import 'package:flutter/material.dart';
import 'package:just_another_sudoku/data/models/color_theme.dart';
import 'package:just_another_sudoku/theme/color_contants.dart';
// import 'package:just_another_sudoku/ui/home_page.dart';
import 'package:just_another_sudoku/ui/game/sudoku_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final preferredColor = ColorConstants.green;
    return ChangeNotifierProvider(
      create: (context) => ColorTheme(initialColor: preferredColor, colorIndex: 1),
      child: Consumer<ColorTheme>(
        builder: (context, colorTheme, _) {
          return MaterialApp(
            title: 'just another sudoku',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'WorkSans',
              useMaterial3: true,
		  colorScheme: ColorScheme(
                brightness: Brightness.light,
                primary: colorTheme.colorSwatch[0],
                onPrimary: Colors.white,
                secondary: colorTheme.colorSwatch[2],
                onSecondary: colorTheme.colorSwatch[0],
                error: Colors.red,
                onError: Colors.white,
                background: Colors.grey.shade50,
                onBackground: Colors.black,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
            ),
            home: const SudokuPage(),
            // home: const HomePage(),
          );
        }
      ),
    );
  }
}
