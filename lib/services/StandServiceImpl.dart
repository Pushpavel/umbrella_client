import 'dart:async';
import 'dart:collection';

import 'package:rxdart/rxdart.dart';
import 'package:umbrella_client/models/Stand.dart';
import 'package:umbrella_client/services/StandService.dart';

class StandServiceImpl implements StandService {
  final Stream<UnmodifiableListView<Stand>> _stands$ =
      Stream.value(UnmodifiableListView([Stand("stand1"), Stand("stand2")]))
          .shareReplay();

  late final _selectedStand$ = BehaviorSubject<Stand>();

  StandServiceImpl() {
    _selectedStand$
        .addStream(_stands$.map((list) => list.first).first.asStream());
  }

  Stream<Stand> getSelectedStand() => _selectedStand$;

  Stream<UnmodifiableListView<Stand>> getStands() => _stands$;

  selectStand(Stand stand) => _selectedStand$.sink.add(stand);

  dispose() => _selectedStand$.close();
}
