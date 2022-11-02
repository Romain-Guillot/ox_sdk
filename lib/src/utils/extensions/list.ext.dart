import 'dart:math' as math;

extension ListSwap<T> on List<T> {

  T? get maybeFirst {
    try {
      return first;
    } on StateError catch (e) {
      return null;
    }
  }
}


extension ListNormalize<T extends num> on List<T> {
  List<double> normalized() {
    final _max = max;
    final _min = min;
    return map((e) => (e - _min) / (math.max(1, _max - _min))).toList();
  }

  double denormalize(double value) {
    return (value * (max-min)) + min;
  }

  double normalize(double value) {
    return (value - min) / (math.max(1, max - min));
  }

  T get max => reduce(math.max);

  T get min => reduce(math.min);
}