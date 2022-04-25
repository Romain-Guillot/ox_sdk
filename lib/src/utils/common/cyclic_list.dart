import 'dart:collection';



class CyclicList<E> extends DoubleLinkedQueue<E> {
  CyclicList(this.limit, {this.reverse = false});

  final int limit;
  final bool reverse;

  @override
  void add(E value) {
    if (reverse) {
      super.addFirst(value);
      while (super.length > limit) {
        super.removeLast();
      }
    } else {
      super.add(value);
      while (super.length > limit) {
        super.removeFirst();
      }
    }
  }
}