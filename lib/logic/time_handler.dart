import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_another_sudoku/ui/common/get_formatted_time.dart';

class TimeHandler extends ChangeNotifier {
  late Stopwatch stopwatch;
  late Timer t;
  late Duration? _initialDuration;

  TimeHandler(Duration? initialDuration) {
    stopwatch = Stopwatch();
    _initialDuration = initialDuration;
  }

  void start() {
    if (stopwatch.isRunning) return;
    stopwatch.start();
    startTimer();
    notifyListeners();
  }

  void stop() {
    stopwatch.stop();
    cancelTimer();
    notifyListeners();
  }

  void reset() {
    _initialDuration = Duration.zero;
    stopwatch.reset();
    notifyListeners();
  }

  String formatTime() {
    final totalElapsed = (_initialDuration ?? Duration.zero) + stopwatch.elapsed;
    
    return getFormattedTime(totalElapsed);
  }

  // periodically update the UI
  void startTimer() {
    t = Timer.periodic(const Duration(seconds: 1), (timer) {
      notifyListeners();
    });
  }

  void cancelTimer() {
    if (t.isActive) {
      t.cancel();
    }
  }

  bool get isRunning => stopwatch.isRunning;

  @override
  void dispose() {
    stop();
    cancelTimer();
    super.dispose();
  }
}
