import 'package:firebase_database/firebase_database.dart';
import 'package:umbrella_client/utils/lang-utils.dart';

class UmbrellaPickupState {
  final String standId;
  final String requestId;
  final String username;
  final String userId;
  final DateTime requestTime;
  final DateTime? acknowledgeTime;

  UmbrellaPickupState({
    required this.standId,
    required this.requestId,
    required this.username,
    required this.userId,
    required this.requestTime,
    this.acknowledgeTime,
  });

  static UmbrellaPickupState? fromRTDB(String standId, DataSnapshot snapshot) {
    if (snapshot.key == null) return null;

    final data = snapshot.value;
    final requestTime = data["requestTime"] as int;
    final acknowledgeTime = data["acknowledgeTime"] as int?;

    return UmbrellaPickupState(
      standId: standId,
      requestId: data["requestId"],
      username: data["username"],
      userId: data["userId"],
      requestTime: requestTime.let((it) {
        return DateTime.fromMillisecondsSinceEpoch(it, isUtc: true);
      }),
      acknowledgeTime: acknowledgeTime?.let((it) {
        return DateTime.fromMillisecondsSinceEpoch(it, isUtc: true);
      }),
    );
  }
}
