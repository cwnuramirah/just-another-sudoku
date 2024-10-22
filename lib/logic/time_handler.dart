import 'dart:async';
import 'package:flutter/material.dart';

class TimeHandler extends ChangeNotifier {
  late Stopwatch stopwatch;
  late Timer t;

  TimeHandler() {
    stopwatch = Stopwatch();
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
    stopwatch.reset();
    notifyListeners();
  }

  String getFormattedTime() {
    var secs = stopwatch.elapsed.inSeconds;
    String seconds = (secs % 60).toString().padLeft(2, '0');
    String minutes = (secs ~/ 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
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
