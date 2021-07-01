import 'dart:async';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:umbrella_client/models/Stand.dart';
import 'package:umbrella_client/services/StandService.dart';

class StandServiceImpl implements StandService {
  late final Stream<UnmodifiableListView<Stand>> _stands;

  final _selectedStand = BehaviorSubject<Stand>();

  StandServiceImpl() {
    _stands = FirebaseFirestore.instance.collection("Stands").snapshots().map(
      (querySnap) {
        final list = querySnap.docs.map((snap) => Stand.fromFirestore(snap));
        return UnmodifiableListView(list);
      },
    ).shareValue();

    _selectedStand
        .addStream(_stands.map((list) => list.first).first.asStream());
  }

  Stream<Stand> getSelectedStand() => _selectedStand;

  Stream<UnmodifiableListView<Stand>> getStands() => _stands;

  selectStand(Stand stand) => _selectedStand.sink.add(stand);

  dispose() => _selectedStand.close();
}
