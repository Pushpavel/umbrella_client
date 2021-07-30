import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:umbrella_client/helpers/extensions/AsyncSnapshotExtension.dart';

useMemoizedStreamResult<T>(
  Stream<T> Function() streamBuilder, [
  List<Object?> keys = const <Object>[],
]) {
  final stream = useMemoized(streamBuilder, keys);
  return useStream(stream).asResult();
}
