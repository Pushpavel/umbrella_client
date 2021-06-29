import 'package:cloud_firestore/cloud_firestore.dart';

class UmbrellaRequest {
  final String id;
  final String userId;
  final Timestamp requestTime;
  final String? umbrellaId;

  final String pickupStandId;
  final Timestamp? dropTime;
  final String dropStandId;
  final Timestamp? pickupTime;

  UmbrellaRequest({
    this.dropTime,
    this.pickupTime,
    required this.pickupStandId,
    required this.dropStandId,
    required this.id,
    required this.userId,
    required this.requestTime,
    this.umbrellaId,
  });

  factory UmbrellaRequest.fromFirestore(QueryDocumentSnapshot snapshot) {
    return UmbrellaRequest(
      dropTime: snapshot.get("drop.time"),
      pickupTime: snapshot.get("pickup.time"),
      pickupStandId: snapshot.get("pickup.stand"),
      dropStandId: snapshot.get("drop.stand"),
      id: snapshot.id,
      userId: snapshot.get("userId"),
      requestTime: snapshot.get("requestTime"),
      umbrellaId: snapshot.get("umbrellaId"),
    );
  }
}
