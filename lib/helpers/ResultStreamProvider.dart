import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/helpers/result/Result.dart';

class ResultStreamProvider<T> extends StreamProvider<Result<T>?> {
  ResultStreamProvider({
    required Create<Stream<T>?> create,
    Widget? child,
  }) : super(
          create: (context) => create(context)?.map((event) => Result(event)),
          initialData: null,
          catchError: (context, error) => Result.error(error as Exception),
          child: child,
        );
}
