import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umbrella_client/models/Stand.dart';
import 'package:umbrella_client/repositories/StandRepo.dart';
import 'package:umbrella_client/utils/provider-utils.dart';
import 'package:umbrella_client/utils/iterable-utils.dart';

final standsProvider = StreamProvider<UnmodifiableListView<Stand>>(unimplemented);

provideStands() {
  return standsProvider.overrideWithProvider(StreamProvider(
    (ref) => StandRepo.getStands(),
  ));
}

final standProvider = StreamProvider.family<Stand?, String>((ref, standId) async* {
  final standsStream = ref.watch(standsProvider.stream);
  await for (final stands in standsStream) {
    yield stands.findOrNull((stand) => stand.id == standId);
  }
});
