import 'dart:async';
import 'dart:collection';
import 'package:umbrella_client/models/Stand.dart';
import 'package:umbrella_client/repositories/StandRepo.dart';
import 'package:umbrella_client/services/StandService.dart';
import 'package:umbrella_client/utils/stream-utils.dart';
import 'package:umbrella_client/utils/iterable-utils.dart';

class StandServiceImpl implements StandService {
  final _stands = StandRepo.getStands().toCachedSubject();

  Stream<UnmodifiableListView<Stand>> getStands() => _stands;

  @override
  Stream<Stand?> getStand(String standId) {
    return _stands.map((stands) => stands.findOrNull((stand) => stand.id == standId));
  }

  dispose() {
    _stands.close();
  }

}
