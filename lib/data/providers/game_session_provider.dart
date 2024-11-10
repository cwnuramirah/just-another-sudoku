import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:just_another_sudoku/data/models/board_model.dart';
import 'package:just_another_sudoku/data/models/game_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameSessionProvider with ChangeNotifier {
  late SharedPreferences _prefs;
  GameModel? _currentGame;
  List<GameModel> _prevGames = [];
  bool isInitialized = false;

  GameSessionProvider() {
    _initPreferences();
  }

  Future<void> _initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadCurrentGame();
    _loadPrevGames();
    isInitialized = true;
    notifyListeners();
  }

  void _loadCurrentGame() {
    String? gameJson = _prefs.getString('currentGame');
    if (gameJson != null) {
      _currentGame = GameModel.fromJson(jsonDecode(gameJson));
    }
  }

  void _loadPrevGames() {
    List<String>? prevGamesJson = _prefs.getStringList('prevGames');
    if (prevGamesJson != null) {
      _prevGames = prevGamesJson
          .map((gameJson) => GameModel.fromJson(jsonDecode(gameJson)))
          .toList();
    }
  }

  Future<void> _saveCurrentGame() async {
    if (isInitialized && _currentGame != null) {
      await _prefs.setString('currentGame', jsonEncode(_currentGame!.toJson()));
    }
  }

  Future<void> _savePrevGames() async {
    if (isInitialized) {
      List<String> prevGamesJson =
          _prevGames.map((game) => jsonEncode(game.toJson())).toList();
      await _prefs.setStringList('prevGames', prevGamesJson);
    }
  }

  void startNewGame(GameModel newGame) {
    // Save the previous ongoing game first
    if (_currentGame != null) {
      _currentGame!.board = null;
      _prevGames.add(_currentGame!);
      _savePrevGames();
    }

    // Initialize the new game
    _currentGame = newGame;
    _currentGame!.startTime = DateTime.now();
    _saveCurrentGame();
    notifyListeners();
  }

  void addBoard(BoardModel board) {
    if (_currentGame != null) {
      _currentGame!.board = board;
      _saveCurrentGame();
      notifyListeners();
    }
  }

  void addMistakeCount() {
    if (_currentGame != null) {
      _currentGame!.mistakeCount++;
      _saveCurrentGame();
      notifyListeners();
    }
  }

  void pauseGame() {
    if (_currentGame != null && _currentGame!.startTime != null) {
      final elapsed = DateTime.now().difference(_currentGame!.startTime!);
      _currentGame!.duration += elapsed;
      _currentGame!.startTime = null;
      _saveCurrentGame();
      notifyListeners();
    }
  }

  void resumeGame() {
    if (_currentGame != null && !_currentGame!.isCompleted) {
      _currentGame!.startTime = DateTime.now();
      _saveCurrentGame();
      notifyListeners();
    }
  }

  void resetGameTime() {
    if (_currentGame != null && !_currentGame!.isCompleted) {
      _currentGame!.duration = Duration.zero;
      _currentGame!.startTime = DateTime.now();
      _saveCurrentGame();
      notifyListeners();
    }
  }

  void completeGame() {
    if (_currentGame != null && !_currentGame!.isCompleted) {
      final elapsed =
          DateTime.now().difference(_currentGame!.startTime ?? DateTime.now());
      _currentGame!.duration += elapsed;
      _currentGame!.isCompleted = true;
      _currentGame!.startTime = null;
      _currentGame!.board = null;

      _prevGames.add(_currentGame!);
      _savePrevGames();
      _prefs.remove('currentGame');
      _currentGame = null;

      notifyListeners();
    }
  }

  Future<void> clearGameRecords() async {
    _prevGames.clear();
    await _prefs.remove('prevGames');
    await _prefs.remove('currentGame');
    notifyListeners();
  }

  GameModel? get currentGame => _currentGame;
  List<GameModel> get prevGames => List.unmodifiable(_prevGames);
}
