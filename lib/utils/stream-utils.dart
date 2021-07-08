import 'package:rxdart/rxdart.dart';

extension StreamUtils<T> on Stream<T> {
  BehaviorSubject<T> toCachedSubject() {
    final subject = BehaviorSubject<T>();
    subject.addStream(this);
    return subject;
  }

  Stream<T> passAndSwitchMap(Stream<T>? Function(T value) mapper) {
    return this.switchMap((value) {
      final mappedValue = mapper(value);
      final Stream<T> mappedStream = mappedValue != null ? mappedValue : Stream.empty();
      return mappedStream.startWith(value);
    });
  }
}
