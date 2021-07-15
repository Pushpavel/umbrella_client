import 'package:umbrella_client/helpers/Lifecycle.dart';
import 'package:rxdart/rxdart.dart';

extension StreamExtensions<T> on Stream<T> {
  ValueStream<T> publishOn(Lifecycle lifecycle) {
    return this.publishValue().autoConnect(connection: (sub) {
      // cancel on Lifecycle dispose
      lifecycle.onDispose(sub.cancel);
    });
  }
}
