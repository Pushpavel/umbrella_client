import 'package:cloud_firestore/cloud_firestore.dart';

class Stand {
  final String name;
  final String id;

  Stand(this.name, this.id);

  factory Stand.fromDynamic(String key, data) {
    return Stand(data["name"], key);
  }

  factory Stand.fromFirestore(DocumentSnapshot snap) {
    return Stand(snap.get("name"), snap.id);
  }
}
