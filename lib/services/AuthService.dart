import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/models/UmbrellaUser.dart';
import 'package:umbrella_client/repositories/AuthRepo.dart';
import 'package:umbrella_client/utils/stream-utils.dart';

class AuthService {
  final _user = AuthRepo.getUser().toCachedSubject();

  late final Stream<UmbrellaUser?> user = _user.stream;

  dispose() {
    _user.close();
  }

  static provider({Widget? child}) {
    return Provider<AuthService>(
      create: (_) => AuthService(),
      dispose: (_, service) => service.dispose(),
      child: child,
    );
  }
}
