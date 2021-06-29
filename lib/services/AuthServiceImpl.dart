import 'package:firebase_auth/firebase_auth.dart';
import 'package:umbrella_client/services/AuthService.dart';

class AuthServiceImpl implements AuthService {

  Stream<User?> getUser() {
    return FirebaseAuth.instance.authStateChanges();
  }

}
