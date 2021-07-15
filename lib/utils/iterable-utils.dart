// TODO: move to helpers/extensions
extension IterableUtils<E> on Iterable<E> {
  E? findOrNull(bool test(E element)) {
    return firstWhere(test, orElse: () => null as E);
  }
}
