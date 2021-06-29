import 'package:firebase_auth/firebase_auth.dart';
import 'package:umbrella_client/models/UmbrellaRequest.dart';

abstract class UmbrellaService {
  Stream<UmbrellaRequest> getLastUmbrellaRequestOfUser(User user);
}
