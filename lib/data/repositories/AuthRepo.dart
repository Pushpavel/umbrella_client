import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:umbrella_client/data/models/UmbrellaUser.dart';
import 'package:rxdart/rxdart.dart';

class AuthRepo {
  static Stream<UmbrellaUser?> getUser() {
    return FirebaseAuth.instance.userChanges().switchMap((user) async* {
      if (user == null) {
        yield null;
        return;
      }

      final userRef = FirebaseFirestore.instance.collection("Users").doc(user.uid);

      yield* userRef.snapshots().map((userData) => UmbrellaUser.fromDynamic(user, userData.data()!));
    });
  }

  static Future<UmbrellaUser?> signInWithGoogle() async {
    // Trigger the authentication flow
    final googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) return null;

    // Obtain the auth details from the request
    final googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final signedInCred = await FirebaseAuth.instance.signInWithCredential(credential);

    if (signedInCred.additionalUserInfo?.isNewUser == true) {
      final userRef = FirebaseFirestore.instance.collection("Users").doc(signedInCred.user!.uid);

      await userRef.set({
        "name": signedInCred.user!.displayName,
      });
    }

    // Once signed in, return UmbrellaUser from UserCredential
    return UmbrellaUser.fromDynamic(signedInCred.user!, {
      "name": signedInCred.user!.displayName!,
    });
  }

  static Future<void> signOut() {
    return FirebaseAuth.instance.signOut();
  }

  AuthRepo._();
}
