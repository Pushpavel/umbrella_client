import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';

extension QueryUtils on Query {
  Stream<UnmodifiableListView<T>> onceAndOnChildChanged<T>(
    T Function(String, dynamic) modelMapper,
  ) async* {
    var onceSnap = await once();

    Map<String, T> standMap = onceSnap.value.map(
      (key, value) => MapEntry(key, modelMapper(key, value)),
    );

    yield UnmodifiableListView(standMap.values);

    if (standMap.isEmpty) return;

    await for (var event in onChildChanged) {
      var key = event.snapshot.key;
      if (key == null) continue;

      standMap[key] = modelMapper(key, event.snapshot.value);
      yield UnmodifiableListView(standMap.values);
    }
  }
}
