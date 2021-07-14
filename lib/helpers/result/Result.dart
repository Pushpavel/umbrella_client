import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'Result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const factory Result(T value) = Success;
  const factory Result.error(Exception exception) = Failure;
}
