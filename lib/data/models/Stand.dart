import 'package:cloud_firestore/cloud_firestore.dart';

class Stand {
  final String name;
  final String id;

  Stand(this.name, this.id);

  factory Stand.fromDynamic(String key, data) {
    return Stand(data["name"], key);
  }

  factory Stand.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snap) {
    final data  = snap.data();
    return Stand(data?["name"], snap.id);
  }
}
