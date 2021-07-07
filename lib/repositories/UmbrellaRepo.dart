import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:umbrella_client/models/UmbrellaRequest.dart';

class UmbrellaRepo {
  static Stream<UmbrellaRequest?> getUmbrellaRequest(String requestId) {
    var query = FirebaseFirestore.instance.collection("Requests").doc(requestId);

    return query.snapshots().map(
      (snap) {
        if (!snap.exists) return null;
        return UmbrellaRequest.fromFirestore(snap);
      },
    );
  }

  static Future<bool> requestUmbrellaPickup(String standId) async {
    final request = FirebaseFunctions.instance.httpsCallable("requestUmbrellaPickup");
    final result = await request({"standId": standId});
    return result.data["success"] != null;
  }

  UmbrellaRepo._();
}
