extension DurtionExt on Duration {
  int get minutes => inMinutes.remainder(60);
  int get seconds => inSeconds.remainder(60);
  int get hours => inHours;
}