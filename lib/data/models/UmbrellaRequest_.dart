import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:umbrella_client/helpers/errors/Err.dart';

@Deprecated("")
class UmbrellaRequest_ {
  final String id;
  final String userId;
  final Timestamp requestTime;
  final String? umbrellaId;
  final String pickupStandId;
  final Timestamp? dropTime;
  final String? dropStandId;
  final Timestamp? pickupTime;

  final _Failure? failure;

  UmbrellaRequest_({
    this.dropTime,
    this.pickupTime,
    this.dropStandId,
    required this.pickupStandId,
    required this.id,
    required this.userId,
    required this.requestTime,
    this.umbrellaId,
    this.failure,
  });

  factory UmbrellaRequest_.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) throw InternalErr();

    final failure = data.containsKey("failure") ? _Failure(data["failure.reason"], data["failure.time"]) : null;

    return UmbrellaRequest_(
        dropTime: data["drop.time"],
        pickupTime: data["pickup.time"],
        pickupStandId: data["pickup.stand"],
        dropStandId: data["drop.stand"],
        id: snapshot.id,
        userId: data["userId"],
        requestTime: data["requestTime"],
        umbrellaId: data["umbrellaId"],
        failure: failure);
  }

  UmbrellaRequestStatus get status {
    if (failure != null) return UmbrellaRequestStatus.FAILED;
    if (dropTime != null) return UmbrellaRequestStatus.DROPPED;
    if (pickupTime != null) return UmbrellaRequestStatus.PICKED_UP;
    return UmbrellaRequestStatus.REQUESTED;
  }
}

class _Failure {
  final String reason;
  final Timestamp time;

  _Failure(this.reason, this.time);
}

enum UmbrellaRequestStatus { REQUESTED, PICKED_UP, DROPPED, FAILED }
