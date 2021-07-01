import 'package:cloud_firestore/cloud_firestore.dart';

class UmbrellaRequest {
  final String id;
  final String userId;
  final Timestamp requestTime;
  final String? umbrellaId;

  final String pickupStandId;
  final Timestamp? dropTime;
  final String? dropStandId;
  final Timestamp? pickupTime;

  final _Failure? failure;

  UmbrellaRequest(
      {this.dropTime,
      this.pickupTime,
      this.dropStandId,
      required this.pickupStandId,
      required this.id,
      required this.userId,
      required this.requestTime,
      this.umbrellaId,
      this.failure});

  factory UmbrellaRequest.fromFirestore(DocumentSnapshot snapshot) {
    final failure = snapshot.get("failure") != null
        ? _Failure(snapshot.get("failure.reason"), snapshot.get("failure.time"))
        : null;

    return UmbrellaRequest(
        dropTime: snapshot.get("drop.time"),
        pickupTime: snapshot.get("pickup.time"),
        pickupStandId: snapshot.get("pickup.stand"),
        dropStandId: snapshot.get("drop.stand"),
        id: snapshot.id,
        userId: snapshot.get("userId"),
        requestTime: snapshot.get("requestTime"),
        umbrellaId: snapshot.get("umbrellaId"),
        failure: failure);
  }

  get status {
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
