import 'package:just_another_sudoku/data/models/game_model.dart';

class StatisticsModel {
  late List<GameModel> games;

  StatisticsModel({
    List<GameModel>? games,
  }) : games = games ?? [];

  int get gamesStarted => games.length;

  int get completedGames {
    return games.where((game) => game.isCompleted).length;
  }

  int get completedGamesWithoutMistake {
    return games
        .where((game) => game.isCompleted && (game.mistakeCount == 0))
        .length;
  }

  double get completedRate {
    double rate = 0.0;
    if (games.isEmpty || completedGames == 0) return rate;

    rate = ((completedGames / gamesStarted) * 100);
    return rate;
  }

  int get averageMistakesPerGame {
    int avg = 0;
    if (completedGames == 0) return avg;

    int totalMistakes = games.fold(0, (sum, game) => sum + game.mistakeCount);
    avg = (totalMistakes / completedGames).round();
    return avg;
  }
}
