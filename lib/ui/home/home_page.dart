import 'package:flutter/material.dart';
import 'package:just_another_sudoku/ui/game/sudoku_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "just another sudoku",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 16.0),
              TextButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(width: 1.2, color: Colors.black),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SudokuPage()),
                  );
                },
                child: const Text("Easy"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
