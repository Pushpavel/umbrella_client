import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umbrella_client/helpers/errors/Err.dart';
import 'package:umbrella_client/helpers/result/Result.dart';

extension refe<T> on AsyncValue<T> {
  Result<T>? asResult() {
    return this.when(
        data: (T value) => Result(value),
        loading: () => null,
        error: (Object error, StackTrace? stackTrace) {
          if (error is Err)
            return Result.error(error);
          else
            return Result.error(Err(error, stackTrace));
        });
  }
}
