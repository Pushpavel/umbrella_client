import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/services/StandService.dart';
import 'package:umbrella_client/services/StandServiceImpl.dart';

abstract class Providers {
  static standService({Widget? child}) => Provider<StandService>(
        create: (_) => StandServiceImpl(),
        dispose: (_, service) => service.dispose(),
        child: child,
      );
}
