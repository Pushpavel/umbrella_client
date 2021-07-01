import 'package:firebase_auth/firebase_auth.dart';

class UmbrellaUser {
  final String name;
  final String? requestId;
  final User auth;

  UmbrellaUser._({required this.name, this.requestId, required this.auth});

  factory UmbrellaUser.fromDynamic(User auth, Map<dynamic, dynamic> data) {
    return UmbrellaUser._(
      name: data["name"],
      requestId: data["requestId"],
      auth: auth,
    );
  }
}
