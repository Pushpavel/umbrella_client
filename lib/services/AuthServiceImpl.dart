import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:umbrella_client/models/UmbrellaUser.dart';
import 'package:umbrella_client/repositories/AuthRepo.dart';
import 'package:umbrella_client/services/AuthService.dart';
import 'package:umbrella_client/utils/stream-utils.dart';

class AuthServiceImpl implements AuthService {
  final _user = AuthRepo.getUser().toCachedSubject();

  Stream<UmbrellaUser?> getUser() => _user.stream;

  Future<UmbrellaUser?> signInWithGoogle() async {
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

    // Once signed in, return the UserCredential
    return UmbrellaUser.fromDynamic(signedInCred.user!, {
      "name": signedInCred.user!.displayName!,
    });
  }

  @override
  dispose() => _user.close();
}
