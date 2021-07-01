import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/services/AuthService.dart';
import 'package:umbrella_client/services/AuthServiceImpl.dart';
import 'package:umbrella_client/services/StandService.dart';
import 'package:umbrella_client/services/StandServiceImpl.dart';
import 'package:umbrella_client/services/UmbrellaService.dart';
import 'package:umbrella_client/services/UmbrellaServiceImpl.dart';

abstract class Providers {
  static standService({Widget? child}) => Provider<StandService>(
        create: (_) => StandServiceImpl(),
        dispose: (_, service) => service.dispose(),
        child: child,
      );

  static authService({Widget? child}) => Provider<AuthService>(
        create: (_) => AuthServiceImpl(),
        dispose: (_, service) => service.dispose(),
        child: child,
      );

  static umbrellaService({Widget? child}) => Provider<UmbrellaService>(
        create: (_) => UmbrellaServiceImpl(),
        child: child,
      );
}
