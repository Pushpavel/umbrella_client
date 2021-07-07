import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:umbrella_client/models/AppState.dart';
import 'package:rxdart/rxdart.dart';
import 'package:umbrella_client/repositories/AuthRepo.dart';
import 'package:umbrella_client/repositories/UmbrellaRepo.dart';
import 'package:umbrella_client/utils/stream-utils.dart';

class AppService {
  const AppService._();

  static provider({Widget? child}) {
    return StreamProvider<AppState?>(
      create: _createAppStateStream,
      initialData: null,
      child: child,
    );
  }
}

Stream<AppState> _createAppStateStream(_) async* {
  // initialize Firebase
  await Firebase.initializeApp();

  yield* Stream.value(AppState())
      .switchMap((state) => AuthRepo.getUser().map((user) => state.copyWith(user: user)))
      .passAndSwitchMap(_createRequestStream)
      .shareValue();
}

Stream<AppState> _createRequestStream(AppState state) async* {
  if (state.user == null || state.user!.requestId == null) return;

  await for (final request in UmbrellaRepo.getUmbrellaRequest(state.user!.requestId!))
    yield state.copyWith(currentRequest: request);
}
