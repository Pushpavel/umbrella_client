import 'package:rxdart/rxdart.dart';

extension StreamUtils<T> on Stream<T> {
  BehaviorSubject<T> toCachedSubject() {
    final subject = BehaviorSubject<T>();
    subject.addStream(this);
    return subject;
  }
}
