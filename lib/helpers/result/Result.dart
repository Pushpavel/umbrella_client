import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'Result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const Result._();

  factory Result(T value) = Success;

  factory Result.error(Exception exception) = Failure;

  T? getOrNull() {
    return when((value) => value, error: (e) => null);
  }
}
