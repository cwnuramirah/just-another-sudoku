import 'package:flutter/material.dart';
// import 'package:just_another_sudoku/ui/home_page.dart';
import 'package:just_another_sudoku/ui/sudoku_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'just another sudoku',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'WorkSans',
        useMaterial3: true,
      ),
      // home: const HomePage(),
      home: const SudokuPage(),
    );
  }
}
