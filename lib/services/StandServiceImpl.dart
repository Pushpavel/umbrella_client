import 'dart:async';
import 'dart:collection';
import 'package:umbrella_client/models/Stand.dart';
import 'package:umbrella_client/repositories/StandRepo.dart';
import 'package:umbrella_client/services/StandService.dart';
import 'package:umbrella_client/utils/stream-utils.dart';

class StandServiceImpl implements StandService {
  final _stands = StandRepo.getStands().toCachedSubject();
  late final _selectedStand;

  StandServiceImpl() {
    _selectedStand = _stands.map((list) => list.first).first.asStream().toCachedSubject();
  }

  Stream<Stand> getSelectedStand() => _selectedStand;

  Stream<UnmodifiableListView<Stand>> getStands() => _stands;

  selectStand(Stand stand) => _selectedStand.add(stand);

  dispose() {
    _selectedStand.close();
    _stands.close();
  }
}
