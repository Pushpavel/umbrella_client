import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umbrella_client/data/models/UmbrellaRequest.dart';
import 'package:umbrella_client/pages/DropScreen.dart';
import 'package:umbrella_client/pages/HomeScreen.dart';
import 'package:umbrella_client/pages/LoginScreen.dart';
import 'package:umbrella_client/pages/PickupScreen.dart';
import 'package:umbrella_client/pages/LoadingScreen.dart';
import 'package:umbrella_client/data/repositories/UmbrellaRepo.dart';
import 'package:umbrella_client/data/services/AuthService.dart';
import 'package:umbrella_client/utils/nav-utils.dart';
import 'package:rxdart/rxdart.dart';

class AppNavigator extends StatefulWidget {
  final AuthService authService;

  const AppNavigator({Key? key, required this.authService}) : super(key: key);

  @override
  _AppNavigatorState createState() =>
      _AppNavigatorState(authService: authService);
}

class _AppNavigatorState extends State<AppNavigator> {
  final AuthService authService;
  StreamSubscription? _sub;

  _AppNavigatorState({required this.authService});

  @override
  void initState() {
    super.initState();

    _sub = authService.user.switchMap((user) async* {
      // unauthenticated user
      if (user == null) {
        await context.resetNavStackWith(LoginScreen());
        return;
      }

      // user with no request
      if (user.requestId == null) {
        await context.resetNavStackWith(HomeScreen());
        return;
      }

      final requestStream = UmbrellaRepo.getUmbrellaRequest(user.requestId!);

      yield* requestStream
          .map((request) => request?.status)
          .distinct()
          .switchMap((status) async* {

        if (status == null) throw Exception("Internal Error");

        switch (status) {
          case UmbrellaRequestStatus.REQUESTED:
            await context.resetNavStackWith(PickupScreen(
              requestStream: requestStream.map((event) => event!),
            ));
            break;
          case UmbrellaRequestStatus.PICKED_UP:
            await context.resetNavStackWith(DropScreen(
              requestStream: requestStream.map((event) => event!),
            ));
            break;
          case UmbrellaRequestStatus.FAILED:
            //TODO : handle failed irkanae therla :)
            break;
          default:
        }
      });
    }).listen((event) => null);
  }

  @override
  void dispose() {
    super.dispose();
    _sub?.cancel();
  }

  @override
  Widget build(BuildContext context) => LoadingScreen();
}
