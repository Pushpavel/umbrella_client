import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:umbrella_client/services/AuthService.dart';

class AuthServiceImpl implements AuthService {
  Stream<User?> getUser() {
    return FirebaseAuth.instance.authStateChanges();
  }

  Future<User?> signInWithGoogle() async {
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

    final signedInCred =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // Once signed in, return the UserCredential
    return signedInCred.user;
  }
}
