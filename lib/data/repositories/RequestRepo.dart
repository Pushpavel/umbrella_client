import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:umbrella_client/data/models/UmbrellaRequest.dart';

class RequestRepo {
  RequestRepo._();

  static Stream<UmbrellaRequest?> getUmbrellaRequest(String requestId) {
    final query = FirebaseFirestore.instance.collection("Requests").doc(requestId);

    return query.snapshots().map(
      (snap) {
        if (!snap.exists) return null;
        return UmbrellaRequest.fromFirestore(snap);
      },
    );
  }
}
