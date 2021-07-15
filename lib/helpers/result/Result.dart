import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:umbrella_client/helpers/errors/Err.dart';

part 'Result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const Result._();

  factory Result(T value) = Success;

  factory Result.error(Err exception) = Failure;

  T? getOrNull() {
    return when((value) => value, error: (e) => null);
  }

  T getOrThrow() {
    return when((value) => value, error: (e) => throw e);
  }

  static E getOrThrowErr<E>(Result<E>? result) {
    if (result == null) throw "Result<$E> is null";

    return result.getOrThrow();
  }
}
