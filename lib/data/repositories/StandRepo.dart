import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:umbrella_client/data/models/Stand.dart';

class StandRepo {
  static Stream<UnmodifiableListView<Stand>> getStands() {
    return FirebaseFirestore.instance.collection("Stands").snapshots().map(
      (querySnap) {
        final list = querySnap.docs.map((snap) => Stand.fromFirestore(snap));
        return UnmodifiableListView(list);
      },
    );
  }

  static Stream<Stand?> getStand(String standId) {
    return FirebaseFirestore.instance
        .collection("Stands")
        .doc(standId)
        .snapshots()
        .map((snap) => Stand.fromFirestore(snap));
  }

  StandRepo._();
}
