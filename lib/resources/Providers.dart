import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/services/AuthService.dart';
import 'package:umbrella_client/services/AuthServiceImpl.dart';
import 'package:umbrella_client/services/StandService.dart';
import 'package:umbrella_client/services/StandServiceImpl.dart';

abstract class Providers {
  static standService({Widget? child}) => Provider<StandService>(
        create: (_) => StandServiceImpl(),
        dispose: (_, service) => service.dispose(),
        child: child,
      );

  static authService({Widget? child}) => Provider<AuthService>(
        create: (_) => AuthServiceImpl(),
        child: child,
      );
}
