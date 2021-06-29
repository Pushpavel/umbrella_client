import 'dart:collection';

import 'package:umbrella_client/models/Stand.dart';
import 'package:umbrella_client/pages/DropScreen.dart';
import 'package:umbrella_client/pages/PickupScreen.dart';
import 'package:umbrella_client/pages/RetrySignInScreen.dart';
import 'package:umbrella_client/pages/StandListScreen.dart';
import 'package:umbrella_client/resources/Providers.dart';

abstract class Routes {
  // RetrySignInScreen
  static final retrySignIn = (_) => RetrySignInScreen();

  // PickupScreen
  static final pickup = (_) => PickupScreen();

  // DropScreen
  static final drop = (_) => Providers.standService(child: DropScreen());

  // StandListScreen
  static standList(Stream<UnmodifiableListView<Stand>> stands) =>
      (_) => StandListScreen(stands);
}
