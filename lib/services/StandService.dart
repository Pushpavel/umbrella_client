import 'dart:collection';

import 'package:umbrella_client/models/Stand.dart';

abstract class StandService {
  Stream<UnmodifiableListView<Stand>> getStands();

  Stream<Stand> getSelectedStand();

  selectStand(Stand stand);

  dispose();
}
