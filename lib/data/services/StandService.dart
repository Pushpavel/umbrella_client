import 'dart:collection';

import 'package:umbrella_client/data/models/Stand.dart';
import 'package:umbrella_client/data/repositories/StandRepo.dart';
import 'package:umbrella_client/helpers/DisposableProvider.dart';
import 'package:umbrella_client/utils/stream-utils.dart';
import 'package:umbrella_client/utils/iterable-utils.dart';

class StandService implements Disposable {
  final _stands = StandRepo.getStands().toCachedSubject();

  Stream<UnmodifiableListView<Stand>> getStands() => _stands;

  Stream<Stand?> getStand(String standId) {
    return _stands.map((stands) => stands.findOrNull((stand) => stand.id == standId));
  }

  dispose() => _stands.close();
}
