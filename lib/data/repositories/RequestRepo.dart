import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
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

  static Stream<UmbrellaRequest?> getRecentUmbrellaRequest(String userId) {
    final query = FirebaseFirestore.instance
        .collection("Requests")
        .where("userId", isEqualTo: userId)
        .orderBy("requestTime", descending: true)
        .limit(1);

    return query.snapshots().map(
      (snap) {
        if (snap.size == 0) return null;
        return UmbrellaRequest.fromFirestore(snap.docs[0]);
      },
    );
  }

  static Future<bool> requestUmbrellaPickup(String standId) async {
    final request = FirebaseFunctions.instanceFor(region: "asia-south1").httpsCallable("requestUmbrellaPickup");
    final result = await request({"standId": standId});
    // TODO: handle failure states
    return result.data["success"] != null;
  }
}
