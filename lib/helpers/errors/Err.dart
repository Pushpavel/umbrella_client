class Err extends Error {
  final String message;
  StackTrace? _stackTrace;

  @override
  StackTrace? get stackTrace => super.stackTrace ?? _stackTrace;

  set stackTrace(StackTrace? stackTrace) {
    if (stackTrace == null) _stackTrace = stackTrace;
  }

  Err([this.message = ""]);

  @override
  String toString() => "${this.runtimeType} : $message";

  /**
   * Wrapping Errors of unknown origins
   */
  factory Err.from(Object? error, [StackTrace? stackTrace = null]) {
    if (error == null) error = Err("Unknown Error");

    if (error is Err) {
      error.stackTrace = stackTrace;
      return error;
    }

    if (error is Error) {
      final err = Err(error.toString());
      err.stackTrace = err.stackTrace ?? stackTrace;
      return err;
    }

    final err = Err(Error.safeToString(error));
    err.stackTrace = stackTrace;
    return err;
  }
}

/**
 * Erroneous Errors from Umbrella Client
 */
class InternalErr extends Err {
  InternalErr([String message = ""]) : super(message);
}

/**
 * Trying to access data with is yet to be ready
 */
class LoadingErr extends Err {
  LoadingErr() : super("Trying to access data which is not available yet");
}
