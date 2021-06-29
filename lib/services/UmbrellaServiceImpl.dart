import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:umbrella_client/models/UmbrellaRequest.dart';
import 'package:umbrella_client/services/UmbrellaService.dart';

class UmbrellaServiceImpl extends UmbrellaService {
  @override
  Stream<UmbrellaRequest?> getLastUmbrellaRequestOfUser(User user) {
    var query = FirebaseFirestore.instance
        .collection("Requests")
        .where("userId", isEqualTo: user.uid)
        .orderBy("requestTime", descending: true)
        .limit(1);

    return query.snapshots().map(
      (querySnap) {
        if (querySnap.docs.isEmpty) return null;
        return UmbrellaRequest.fromFirestore(querySnap.docs.first);
      },
    );
  }
}
