import 'package:just_another_sudoku/data/models/game_model.dart';

class StatisticsModel {
  late List<GameModel> games;
  late final List<GameModel> _completedGames;

  StatisticsModel({
    List<GameModel>? games,
  }) : games = games ?? [],
  _completedGames = games != null ? games.where((game) => game.isCompleted).toList() : [];

  int get gamesStarted => games.length;

  int get completedGamesCount {
    return _completedGames.length;
  }

  int get completedGamesWithoutMistake {
    return games
        .where((game) => game.isCompleted && (game.mistakeCount == 0))
        .length;
  }

  String get completedRate {
    double rate = 0.00;
    if (games.isEmpty || completedGamesCount == 0) return "-";

    rate = ((completedGamesCount / gamesStarted) * 100);

    return "${rate.toStringAsFixed(1)}%";
  }

  int get averageMistakesPerGame {
    int avg = 0;
    if (completedGamesCount == 0) return avg;

    int totalMistakes = games.fold(0, (sum, game) => sum + game.mistakeCount);
    avg = (totalMistakes / completedGamesCount).round();
    return avg;
  }

  Duration get bestTime {
    Duration duration = _completedGames.first.duration;

    for (GameModel game in _completedGames) {
      if (game.duration < duration) {
        duration = game.duration;
      }
    }

    return duration;
  }

  Duration get averageTime {
    if (completedGamesCount == 0) return Duration.zero;

    Duration totalDuration =
        games.fold(Duration.zero, (sum, game) => sum + game.duration);

    int avgMiliseconds = totalDuration.inMilliseconds ~/ completedGamesCount;
    return Duration(milliseconds: avgMiliseconds);
  }
}
