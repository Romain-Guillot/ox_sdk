import 'dart:collection';

class CyclicList<E> extends Iterable<E> {
  CyclicList(this.limit, {this.reverse = false});

  final _queue = DoubleLinkedQueue<E>();

  final int limit;
  final bool reverse;

  void add(E value) {
    if (reverse) {
      _queue.addFirst(value);
      while (super.length > limit) {
        _queue.removeLast();
      }
    } else {
      _queue.add(value);
      while (super.length > limit) {
        _queue.removeFirst();
      }
    }
  }

  @override
  Iterator<E> get iterator => _queue.iterator;
}
