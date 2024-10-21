import 'package:flutter/material.dart';

class SettingsModel with ChangeNotifier {
  late bool _highlightSameNumber;
  late bool _highlightViolation;
  late bool _compareToSolution;

  SettingsModel({
    bool? highlightSameNumber,
    bool? highlightViolation,
    bool? compareToSolution,
  }) {
    _highlightSameNumber = highlightSameNumber ?? true;
    _highlightViolation = highlightViolation ?? true;
    _compareToSolution = compareToSolution ?? false;
  }

  bool get highlightSameNumber => _highlightSameNumber;
  bool get highlightViolation => _highlightViolation;
  bool get compareToSolution => _compareToSolution;

  void switchHighlightSameNumber(bool value) {
    _highlightSameNumber = value;
    notifyListeners();
  }

  void switchHighlightViolation(bool value) {
    _highlightViolation = value;
    notifyListeners();
  }
  
  void switchCompareToSolution(bool value) {
    _compareToSolution = value;
    notifyListeners();
  }
}
