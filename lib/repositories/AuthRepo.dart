import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:umbrella_client/models/UmbrellaUser.dart';

class AuthRepo {
  static Stream<UmbrellaUser?> getUser() {
    return FirebaseAuth.instance.authStateChanges().asyncMap((user) async {
      if (user == null) return null;
      final userRef = FirebaseFirestore.instance.collection("Users").doc(user.uid);

      final userData = await userRef.get();
      return UmbrellaUser.fromDynamic(user, userData.data()!);
    });
  }

  AuthRepo._();
}
