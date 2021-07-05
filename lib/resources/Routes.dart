import 'dart:collection';

import 'package:umbrella_client/models/Stand.dart';
import 'package:umbrella_client/pages/DropScreen.dart';
import 'package:umbrella_client/pages/HomeScreen.dart';
import 'package:umbrella_client/pages/RetrySignInScreen.dart';
import 'package:umbrella_client/pages/StandListScreen.dart';
import 'package:umbrella_client/pages/PickupScreen.dart';

abstract class Routes {
  // RetrySignInScreen
  static final retrySignIn = (_) => RetrySignInScreen();

  // HomeScreen
  static final home = (_) => HomeScreen();

  // DropScreen
  static final drop = (_) => DropScreen();

  //TimerScreen
  static pickup(Future<bool> isRequested) => (_) => PickupScreen(isRequested: isRequested);

  // StandListScreen
  static standList(Stream<UnmodifiableListView<Stand>> stands) => (_) => StandListScreen();
}
