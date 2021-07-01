import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:umbrella_client/models/UmbrellaRequest.dart';
import 'package:umbrella_client/services/UmbrellaService.dart';
import 'package:rxdart/rxdart.dart';

class UmbrellaServiceImpl extends UmbrellaService {
  final requestsMap = Map<String, Stream<UmbrellaRequest?>>();

  @override
  Stream<UmbrellaRequest?> getUmbrellaRequest(String requestId) {
    requestsMap.putIfAbsent(requestId, () {
      var query =
          FirebaseFirestore.instance.collection("Requests").doc(requestId);

      return query.snapshots().map(
        (snap) {
          if (!snap.exists) return null;
          return UmbrellaRequest.fromFirestore(snap);
        },
      ).shareValue();
    });

    return requestsMap[requestId]!;
  }
}
