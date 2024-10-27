String getFormattedTime(Duration duration) {
  var secs = duration.inSeconds;
  String seconds = (secs % 60).toString().padLeft(2, '0');
  String minutes = (secs ~/ 60).toString().padLeft(2, '0');
  return "$minutes:$seconds";
}
