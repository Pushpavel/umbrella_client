import 'package:flutter/cupertino.dart';
import 'package:umbrella_client/helpers/DisposableProvider.dart';

class Lifecycle extends Disposable {
  final listeners = List<Function>.empty(growable: true);

  void onDispose(Function() listener) => listeners.add(listener);

  @override
  @mustCallSuper
  dispose() {
    listeners.forEach((action) => action());
  }
}
