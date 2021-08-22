import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:umbrella_client/helpers/errors/Err.dart';

part 'Result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const Result._();

  const factory Result(T value) = Success;

  const factory Result.error(Err exception) = Failure;

  const factory Result.loading() = Loading;

  T? getOrNull() {
    return when(
      (value) => value,
      error: (e) {
        print("ERROR THROWN: $e\nstacktrace: ${e.stackTrace}");
        return null;
      },
      loading: () => null,
    );
  }

  T getOrThrow() {
    return when((value) => value, error: (e) => throw e, loading: () => throw LoadingErr());
  }

  Result<E> mapData<E>(E Function(T value) predicate) {
    return when((value) => Result(predicate(value)), error: (e) => Result.error(e), loading: () => Result.loading());
  }

  // TODO: this won't be necessary
  static E getOrThrowErr<E>(Result<E>? result) {
    if (result == null) throw "Result<$E> is null";

    return result.getOrThrow();
  }
}
