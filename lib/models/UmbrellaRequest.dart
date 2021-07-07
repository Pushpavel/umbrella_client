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

  factory UmbrellaRequest.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) throw Exception("Internal Error");

    final failure = data.containsKey("failure")
        ? _Failure(data["failure.reason"], data["failure.time"])
        : null;

    return UmbrellaRequest(
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
