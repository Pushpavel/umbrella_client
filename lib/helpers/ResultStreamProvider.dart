import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/helpers/errors/Err.dart';
import 'package:umbrella_client/helpers/result/Result.dart';

class ResultStreamProvider<T> extends StreamProvider<Result<T>?> {
  ResultStreamProvider({
    required Create<Stream<T>?> create,
    Widget? child,
  }) : super(
          create: (context) => create(context)?.map((event) => Result(event)),
          initialData: null,
          catchError: (context, error) {
            if (error is Err) return Result.error(error);

            return Result.error(Err(error, null));
          },
          child: child,
        );
}
