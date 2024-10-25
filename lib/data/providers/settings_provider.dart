import 'package:flutter/material.dart';
import 'package:just_another_sudoku/data/models/color_theme.dart';
import 'package:just_another_sudoku/data/models/preferences.dart';
import 'package:just_another_sudoku/theme/color_contants.dart';
import 'package:shared_preferences/shared_preferences.dart';

// TODO: Add error handling
//  - Initializing [SharedPreferences] fails (e.g., due to device limitations or storage issues),
//  `_isInitialized` will remain false, and none of the settings will update in the UI.

class SettingsProvider with ChangeNotifier {
  late SharedPreferences _prefs;
  late Preferences _preferences;
  late ColorTheme _activeColorTheme;
  int _activeThemeIndex = 0;
  bool _isInitialized = false;

  SettingsProvider() {
    _preferences = Preferences(
      highlightSameNumbers: true,
      highlightViolation: true,
      compareWithSolution: false,
    );
    _activeColorTheme = ColorTheme();
    _initPreferences();
  }

  Future<void> _initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _activeThemeIndex = _prefs.getInt('activeThemeIndex') ?? 0;
    _activeColorTheme.color = _getColorThemeByIndex(_activeThemeIndex);

    _preferences = Preferences(
      highlightSameNumbers: _prefs.getBool('highlightSameNumbers') ?? true,
      highlightViolation: _prefs.getBool('highlightViolation') ?? true,
      compareWithSolution: _prefs.getBool('compareWithSolution') ?? false,
    );

    _isInitialized = true;
    notifyListeners();
  }

  // Getters
  bool get isInitialized => _isInitialized;
  Preferences get preferences => _preferences;
  ColorTheme get activeColorTheme => _activeColorTheme;
  int get activeThemeIndex => _activeThemeIndex;

  Future<void> _updatePreference(Function() function) async {
    if (_isInitialized) {
      function();
    }
  }

  void toggleHighlightSameNumbers(bool value) {
    _preferences.highlightSameNumbers = value;
    _updatePreference(() => _prefs.setBool('highlightSameNumbers', value));
    notifyListeners();
  }

  void toggleHighlightViolation(bool value) {
    _preferences.highlightViolation = value;
    _updatePreference(() => _prefs.setBool('highlightViolation', value));
    notifyListeners();
  }

  void toggleCompareWithSolution(bool value) {
    _preferences.compareWithSolution = value;
    _updatePreference(() => _prefs.setBool('compareWithSolution', value));
    notifyListeners();
  }

  void changeColorTheme(int newThemeIndex) {
    _activeThemeIndex = newThemeIndex;
    _activeColorTheme.color = _getColorThemeByIndex(newThemeIndex);
    _updatePreference(() => _prefs.setInt('activeThemeIndex', _activeThemeIndex));
    notifyListeners();
  }

  List<Color> _getColorThemeByIndex(int index) {
    switch (index) {
      case 0:
        return ColorConstants.blue;
      case 1:
        return ColorConstants.purple;
      case 2:
        return ColorConstants.green;
      case 3:
        return ColorConstants.yellow;
      default:
        return ColorConstants.blue;
    }
  }
}
