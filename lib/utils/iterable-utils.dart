extension IterableUtils<T> on Iterable<T> {
  T? findOrNull(bool test(T element)) {
    return firstWhere(test, orElse: () => null as T);
  }
}
