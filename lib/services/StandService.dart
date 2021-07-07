import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/models/Stand.dart';
import 'package:umbrella_client/repositories/StandRepo.dart';
import 'package:umbrella_client/utils/stream-utils.dart';
import 'package:umbrella_client/utils/iterable-utils.dart';

class StandService {
  final _stands = StandRepo.getStands().toCachedSubject();

  Stream<UnmodifiableListView<Stand>> getStands() => _stands;

  Stream<Stand?> getStand(String standId) {
    return _stands.map((stands) => stands.findOrNull((stand) => stand.id == standId));
  }

  dispose() => _stands.close();

  static provider({Widget? child}) {
    return Provider<StandService>(
      create: (context) => StandService(),
      dispose: (_, service) => service.dispose(),
      child: child,
    );
  }
}
