import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umbrella_client/helpers/errors/Err.dart';
import 'package:umbrella_client/helpers/result/Result.dart';

extension refe<T> on AsyncValue<T> {
  Result<T> asResult() {
    return this.when(
        data: (T value) => Result(value),
        loading: () => Result.loading(),
        error: (Object error, StackTrace? stackTrace) => Result.error(Err.from(error, stackTrace)));
  }
}
