import 'dart:async';
import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';
import 'package:umbrella_client/models/Stand.dart';
import 'package:umbrella_client/services/StandService.dart';
import 'package:umbrella_client/utils/firebase-utils.dart';

class StandServiceImpl implements StandService {
  late final Stream<UnmodifiableListView<Stand>> _stands;

  final _selectedStand = BehaviorSubject<Stand>();

  StandServiceImpl() {
    _stands = FirebaseDatabase.instance
        .reference()
        .child("stands")
        .onceAndOnChildChanged((k, v) => Stand.fromDynamic(k, v))
        .shareValue();
    _selectedStand
        .addStream(_stands.map((list) => list.first).first.asStream());
  }

  Stream<Stand> getSelectedStand() => _selectedStand;

  Stream<UnmodifiableListView<Stand>> getStands() => _stands;

  selectStand(Stand stand) => _selectedStand.sink.add(stand);

  dispose() => _selectedStand.close();
}
