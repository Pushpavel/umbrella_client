import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Stream<User?> getUser();
}
