import 'package:cloud_firestore/cloud_firestore.dart';

class Stand {
  final String name;
  final String id;
  final String requestId;

  Stand({
    required this.id,
    required this.name,
    required this.requestId,
  });

  factory Stand.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snap) {
    final data = snap.data();
    return Stand(
      id: snap.id,
      name: data?["name"],
      requestId: data?["requestId"],
    );
  }
}
