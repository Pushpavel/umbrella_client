import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/models/Stand.dart';
import 'package:umbrella_client/services/StandServiceImpl.dart';

abstract class StandService {
  Stream<UnmodifiableListView<Stand>> getStands();

  Stream<Stand?> getStand(String standId);

  dispose();

  static provider({Widget? child}) {
    return Provider<StandService>(
      create: (context) => StandServiceImpl(),
      dispose: (_, service) => service.dispose(),
      child: child,
    );
  }
}
