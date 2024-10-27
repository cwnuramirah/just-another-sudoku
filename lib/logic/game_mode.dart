enum GameMode { easy, normal, hard }

getGameModeText(GameMode mode) {
  List<String> splitted = mode.toString().split('.').last.split('');
  String firstLetter = splitted.removeAt(0).toUpperCase();
  splitted.insert(0, firstLetter);

  return splitted.join('');
}
