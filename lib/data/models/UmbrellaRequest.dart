import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:umbrella_client/helpers/errors/Err.dart';

class UmbrellaRequest {
  final String id;
  final String userId;
  final DateTime requestTime;
  final String? umbrellaId;
  final TimeAndStand<DateTime?> pickup;
  final TimeAndStand<DateTime>? drop;
  final RequestFailure? failure;

  UmbrellaRequest({
    required this.id,
    required this.userId,
    required this.requestTime,
    required this.pickup,
    this.drop,
    this.umbrellaId,
    this.failure,
  });

  get status {
    if (failure != null) return RequestStatus.FAILED;
    if (drop != null) return RequestStatus.SUCCESS;
    if (umbrellaId != null) return RequestStatus.DROP;
    return RequestStatus.PICK_UP;
  }

  factory UmbrellaRequest.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (!snapshot.exists) throw InternalErr();
    final data = snapshot.data()!;

    return UmbrellaRequest(
      id: snapshot.id,
      userId: data["userId"],
      requestTime: data["requestTime"].toDate(),
      umbrellaId: data["umbrellaId"],
      pickup: TimeAndStand(data["pickup.time"]?.toDate(), data["pickup.stand"]),
      drop: data.containsKey("drop") ? TimeAndStand(data["drop.time"].toDate(), data["drop.stand"]) : null,
      failure: data.containsKey("failed") ? RequestFailure(data["failed.code"], data["failed.time"].toDate()) : null,
    );
  }
}

class TimeAndStand<T extends DateTime?> {
  final T time;
  final String standId;

  TimeAndStand(this.time, this.standId);
}

class RequestFailure {
  final int code;
  final DateTime time;

  RequestFailure(this.code, this.time);
}

enum RequestStatus { PICK_UP, DROP, FAILED, SUCCESS }
