import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:umbrella_client/models/UmbrellaRequest.dart';

class UmbrellaRepo {
  static getUmbrellaRequest(String requestId) {
    var query = FirebaseFirestore.instance.collection("Requests").doc(requestId);

    return query.snapshots().map(
      (snap) {
        if (!snap.exists) return null;
        return UmbrellaRequest.fromFirestore(snap);
      },
    );
  }

  UmbrellaRepo._();
}
