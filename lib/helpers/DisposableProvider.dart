import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

abstract class Disposable {
  dispose();
}

class DisposableProvider<T extends Disposable> extends Provider<T> {
  DisposableProvider({
    required Create<T> create,
    Widget? child,
  }) : super(
          create: create,
          dispose: (context, disposable) => disposable.dispose(),
          child: child,
        );
}
