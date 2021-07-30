import 'package:cloud_firestore/cloud_firestore.dart';

class Stand {
  final String name;
  final String id;
  final String? requestId;
  final bool online;
  final int umbrellaCount;
  final int capacity;

  Stand({
    required this.id,
    required this.name,
    required this.online,
    required this.umbrellaCount,
    required this.capacity,
    this.requestId,
  });

  StandStatus getStatus() {
    if (!online) return StandStatus.OFFLINE;
    if (requestId != null) return StandStatus.BUSY;
    if (umbrellaCount <= 0) return StandStatus.EMPTY;
    return StandStatus.READY;
  }

  factory Stand.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snap) {
    final data = snap.data()!;
    return Stand(
      id: snap.id,
      name: data["name"],
      requestId: data["requestId"],
      online: data["online"],
      umbrellaCount: data["umbrellaCount"],
      capacity: data["capacity"],
    );
  }
}

enum StandStatus { BUSY, EMPTY, OFFLINE, READY }
