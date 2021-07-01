import 'package:umbrella_client/models/UmbrellaUser.dart';

abstract class AuthService {
  Stream<UmbrellaUser?> getUser();

  Future<UmbrellaUser?> signInWithGoogle();
}
