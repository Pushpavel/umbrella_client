import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umbrella_client/models/AppState.dart';
import 'package:rxdart/rxdart.dart';
import 'package:umbrella_client/utils/stream-utils.dart';
import 'package:umbrella_client/repositories/AuthRepo.dart';
import 'package:umbrella_client/repositories/UmbrellaRepo.dart';

final appStateProvider = StreamProvider<AppState>((ref) async* {
  // initialize Firebase
  await Firebase.initializeApp();

  yield* Stream.value(AppState())
      .switchMap((state) => AuthRepo.getUser().map((user) => state.copyWith(user: user)))
      .passAndSwitchMap(_createRequestStream);
});

Stream<AppState> _createRequestStream(AppState state) async* {
  if (state.user == null || state.user!.requestId == null) return;

  await for (final request in UmbrellaRepo.getUmbrellaRequest(state.user!.requestId!))
    yield state.copyWith(currentRequest: request);
}
