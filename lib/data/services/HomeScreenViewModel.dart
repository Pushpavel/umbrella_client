import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:umbrella_client/data/services/StandService.dart';
import 'package:umbrella_client/helpers/DisposableProvider.dart';

class HomeScreenViewModel implements Disposable {
  final selectedStandId$ = BehaviorSubject<String>();

  HomeScreenViewModel(BuildContext context) {
    final standService = Provider.of<StandService>(context, listen: false);

    // initializing selectedStandId
    selectedStandId$.addStream(
      standService
          .getStands()
          .where((event) => event.isNotEmpty)
          .map((event) => event.first.id)
          .first
          .asStream(),
    );
  }

  dispose() {
    selectedStandId$.close();
  }
}
