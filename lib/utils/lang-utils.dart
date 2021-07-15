// TODO: move to helpers/extensions
extension LangUtils<T> on T {
  R let<R>(R Function(T it) action) => action(this);
}
