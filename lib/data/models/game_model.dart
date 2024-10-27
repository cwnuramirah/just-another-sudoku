import 'package:just_another_sudoku/data/models/board_model.dart';
import 'package:just_another_sudoku/logic/game_mode.dart';

class GameModel {
  DateTime gameStarted;
  bool isCompleted;
  BoardModel? board;
  GameMode mode;
  int mistakeCount;
  Duration duration;
  DateTime? startTime; // Tracks when the current play session started

  GameModel({
    required this.gameStarted,
    this.isCompleted = false,
    this.board,
    this.mode = GameMode.easy,
    this.mistakeCount = 0,
    this.duration = Duration.zero,
    this.startTime,
  });

  Map<String, dynamic> toJson() => {
    'gameStarted': gameStarted.toIso8601String(),
    'isCompleted': isCompleted,
    'board': board != null ? board!.toJson() : null,
    'mode': mode.toString().split('.').last,
    'mistakeCount': mistakeCount,
    'duration': duration.inSeconds, // Store duration as seconds
    'startTime': startTime?.toIso8601String(), // Optional
  };

  factory GameModel.fromJson(Map<String, dynamic> json) => GameModel(
    gameStarted: DateTime.parse(json['gameStarted']),
    isCompleted: json['isCompleted'],
    board: json['board'] != null ? BoardModel.fromJson(json['board']) : null,
    mode: GameMode.values.firstWhere((e) => e.toString().split('.').last == json['mode']),
    mistakeCount: json['mistakeCount'],
    duration: Duration(seconds: json['duration']),
    startTime: json['startTime'] != null ? DateTime.parse(json['startTime']) : null,
  );
}
