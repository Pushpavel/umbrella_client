import 'package:flutter/widgets.dart';
import 'package:umbrella_client/helpers/errors/Err.dart';
import 'package:umbrella_client/helpers/result/Result.dart';

extension AsyncSnapshotExtension<T> on AsyncSnapshot<T> {
  Result<T> asResult() {
    if (!hasData) return Result.loading();
    if (hasError) return Result.error(Err.from(error, stackTrace));
    return Result(requireData);
  }
}
