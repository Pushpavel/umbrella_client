import 'package:rxdart/rxdart.dart';

class Err extends ErrorAndStackTrace {
  Err(Object? error, StackTrace? stackTrace) : super(error ?? "Unknown Err", stackTrace);
}

class InternalErr extends Err {
  InternalErr(Object error, StackTrace? stackTrace) : super(error, stackTrace);
}
