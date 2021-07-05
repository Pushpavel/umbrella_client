import 'dart:collection';

import 'package:umbrella_client/models/Stand.dart';

abstract class StandService {
  Stream<UnmodifiableListView<Stand>> getStands();

  Stream<Stand?> getStand(String standId);

  dispose();
}
