import 'dart:collection';

import 'package:umbrella_client/data/models/Stand.dart';
import 'package:umbrella_client/data/repositories/StandRepo.dart';
import 'package:umbrella_client/helpers/Lifecycle.dart';
import 'package:umbrella_client/helpers/extensions/StreamExtensions.dart';
import 'package:umbrella_client/utils/iterable-utils.dart';

class StandService extends Lifecycle {
  late final _stands = StandRepo.getStands().publishOn(this);

  Stream<UnmodifiableListView<Stand>> getStands() => _stands;

  Stream<Stand?> getStand(String standId) {
    return _stands.map((stands) => stands.findOrNull((stand) => stand.id == standId));
  }
}
