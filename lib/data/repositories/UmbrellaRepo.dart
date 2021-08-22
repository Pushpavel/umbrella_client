import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:umbrella_client/data/models/UmbrellaPickupState.dart';

class UmbrellaRepo {
  static Stream<UmbrellaPickupState?> getUmbrellaPickupState(String standId) {
    final query = FirebaseDatabase.instance.reference().child("activeStandRequests").child(standId).child("request");

    return query.onValue.map((event) => UmbrellaPickupState.fromRTDB(standId, event.snapshot));
  }

  static Future<bool> requestUmbrellaPickup(String standId) async {
    final request = FirebaseFunctions.instance.httpsCallable("requestUmbrellaPickup");
    final result = await request({"standId": standId});
    return result.data["success"] != null;
  }

  UmbrellaRepo._();
}
