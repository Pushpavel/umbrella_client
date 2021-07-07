import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umbrella_client/models/UmbrellaRequest.dart';
import 'package:umbrella_client/pages/DropScreen.dart';
import 'package:umbrella_client/pages/HomeScreen.dart';
import 'package:umbrella_client/pages/LoginScreen.dart';
import 'package:umbrella_client/pages/PickupScreen.dart';
import 'package:umbrella_client/pages/SplashScreen.dart';
import 'package:umbrella_client/repositories/UmbrellaRepo.dart';
import 'package:umbrella_client/services/AuthService.dart';
import 'package:umbrella_client/utils/nav-utils.dart';
import 'package:rxdart/rxdart.dart';

class AppNavigator extends StatefulWidget {
  final AuthService authService;

  const AppNavigator({Key? key, required this.authService}) : super(key: key);

  @override
  _AppNavigatorState createState() => _AppNavigatorState(authService: authService);
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

      yield* requestStream.switchMap((request) async* {
        if (request == null) throw Exception("Internal Error");

        if (request.status == UmbrellaRequestStatus.REQUESTED)
          await context.resetNavStackWith(PickupScreen());
        else
          await context.resetNavStackWith(DropScreen());
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
