import 'dart:math' as math;

extension ListSwap<T> on List<T> {
  void swap(int index1, int index2) {
    var length = this.length;
    RangeError.checkValidIndex(index1, this, "index1", length);
    RangeError.checkValidIndex(index2, this, "index2", length);
    if (index1 != index2) {
      var tmp1 = this[index1];
      this[index1] = this[index2];
      this[index2] = tmp1;
    }
  }

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